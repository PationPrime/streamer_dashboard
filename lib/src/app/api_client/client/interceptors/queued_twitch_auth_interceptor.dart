import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

import '../../../dto/dto.dart';
import '../../../models/models.dart';
import '../../../shared_controllers/shared_controllers.dart';
import '../../../storage/storage.dart';
import '../../../tools/tools.dart';

// Maybe should add some polymorphism on it?...:)
class QueuedTwitchAuthInterceptor extends QueuedInterceptor {
  late final _appLogger = AppLogger(where: '$this');
  final _localStorage = AppSecureStorage.instance;
  final Dio twitchApiClient;
  final Dio twitchAuthClient;
  final String baseUrl;
  final GoRouter appRouter;
  TwitchTokenModel? _twitchToken;

  final List<
      ({
        ErrorInterceptorHandler handler,
        RequestOptions options,
      })> _requestsNeedRetry = [];

  final List<String> _skipPaths = [];

  QueuedTwitchAuthInterceptor({
    required this.baseUrl,
    required this.appRouter,
    required this.twitchApiClient,
    required this.twitchAuthClient,
  });

  bool _shouldRefreshToken(DioException error) =>
      error.response?.statusCode == 401 || error.response?.statusCode == 403;

  bool _mustForceLogout(DioException error) =>
      error.response?.statusCode == 400 ||
      error.response?.statusCode == 401 ||
      error.response?.statusCode == 403;

  Future<void> _forceLogout({
    String? reason,
    DioException? error,
  }) async {
    try {
      _appLogger.logError(
        'Force logout reason: $reason',
        stackTrace: error?.stackTrace,
      );

      final context = appRouter.configuration.navigatorKey.currentContext;

      if (context is BuildContext && context.mounted) {
        context.read<TwitchAuthorizationController>().signOut();
      } else {
        _appLogger.logError('context not found');
      }
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Force logout error: $error',
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<Either<DioException, TwitchTokenModel>> _refreshToken(
    TwitchTokenModel token,
  ) async {
    try {
      Map<String, dynamic> responseData = {};

      final additionalJsonData = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.twitchAppData,
      );

      final twitchRefreshTokenDto = TwitchRefreshTokenDto(
        refreshToken: token.refreshToken,
        clientId: additionalJsonData['client_id'],
        clientSecret: additionalJsonData['client_secret'],
      );

      final response = await twitchAuthClient.post(
        'token',
        data: twitchRefreshTokenDto.toMap(),
      );

      final data = response.data;

      if (data is String) {
        responseData = jsonDecode(
          response.data,
        );
      } else {
        responseData = data;
      }

      final freshToken = TwitchTokenModel.fromJsonWithLastUpdateTime(
        responseData,
      );

      return Right(freshToken);
    } on DioException catch (error) {
      return Left(error);
    }
  }

  Future<void> _refreshTokenProcess(
    dynamic handler,
  ) async {
    final refreshingResponse = await _refreshToken(
      _twitchToken!,
    );

    await refreshingResponse.fold(
      (error) async {
        _requestsNeedRetry.clear();

        if (_mustForceLogout(error)) {
          return await _forceLogout(
            reason: '_mustForceLogout',
          );
        }

        return handler.reject(error);
      },
      (token) async {
        final additionalJsonData = await JsonTool.readJsonFileFromAsset(
          Assets.additionalData.twitchAppData,
        );

        await _localStorage.deleteTwitchToken();
        await _localStorage.setTwitchToken(token);

        _twitchToken = token;

        for (final requestNeedRetry in _requestsNeedRetry) {
          final headers = requestNeedRetry.options.headers;

          headers['Authorization'] = 'Bearer ${token.accessToken}';
          headers['Client-Id'] = additionalJsonData['client_id'];

          final newOptions = requestNeedRetry.options.copyWith(
            headers: headers,
          );

          try {
            final response = await twitchApiClient.fetch(
              newOptions,
            );

            requestNeedRetry.handler.resolve(response);
          } catch (resolveError) {
            _appLogger.logError(
              'resolveError: $resolveError',
            );
          }
        }

        _requestsNeedRetry.clear();
      },
    );
  }

  ///
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final additionalJsonData = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.twitchAppData,
      );

      final ignoreAuth = _skipPaths.contains(
            options.uri.path,
          ) ||
          options.extra['no_auth_extra'] == true;

      if (ignoreAuth) {
        return handler.next(options);
      }

      _twitchToken = await _localStorage.getTwitchToken();

      if (_twitchToken == null || _twitchToken?.accessToken == null) {
        _appLogger.logError(
          'Twitch token must be provided, but not found',
        );

        return;
      }

      if (_twitchToken is TwitchTokenModel &&
          !_twitchToken!.isAccessTokenAlive) {
        await _refreshTokenProcess(handler).then(
          (_) => handler.next(
            options,
          ),
        );
      }

      final headers = options.headers;

      headers['Authorization'] = 'Bearer ${_twitchToken?.accessToken}';
      headers['Client-Id'] = additionalJsonData['client_id'];

      _appLogger.logArgsList(
        {
          'URL': options.uri,
          'HEADERS': headers,
        },
      );

      final newOptions = options.copyWith(
        headers: headers,
      );

      return handler.next(
        newOptions,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'onRequest error: $error',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _twitchToken = await _localStorage.getTwitchToken();

    final response = err.response;

    if (_shouldRefreshToken(err)) {
      if (_twitchToken is! TwitchTokenModel) {
        return await _forceLogout(
          reason: 'refresh token not found',
        );
      }

      _requestsNeedRetry.add(
        (
          options: response!.requestOptions,
          handler: handler,
        ),
      );

      await _refreshTokenProcess(handler);
    } else {
      handler.next(err);
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) =>
      handler.next(response);
}
