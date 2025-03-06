import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../models/models.dart';
import '../../../storage/storage.dart';
import '../../../tools/tools.dart';

class QueuedMainAuthInterceptor extends QueuedInterceptor {
  late final _appLogger = AppLogger(where: '$this');
  final _localStorage = AppSecureStorage.instance;
  final Dio apiClient;
  final String baseUrl;
  final GoRouter appRouter;
  MainV1TokenModel? _token;

  final List<
      ({
        ErrorInterceptorHandler handler,
        RequestOptions options,
      })> _requestsNeedRetry = [];

  final List<String> _skipPaths = [];

  QueuedMainAuthInterceptor({
    required this.baseUrl,
    required this.appRouter,
    required this.apiClient,
  });

  bool _shouldRefreshToken(DioException error) =>
      (error.response?.statusCode == 401 || error.response?.statusCode == 403);

  bool _mustForceLogout(DioException error) =>
      error.response?.statusCode == 400 ||
      error.response?.statusCode == 401 ||
      error.response?.statusCode == 403;

  Future<void> _forceLogout({
    String? reason,
    DioException? error,
  }) async {
    _appLogger.logError(
      'Force logout reason: $reason',
      stackTrace: error?.stackTrace,
    );

    await _localStorage.deleteToken();

    final context = appRouter.configuration.navigatorKey.currentContext;

    // if (context is BuildContext && context.mounted) {
    //   context.read<AuthorizationController>().signOut();
    // } else {
    //   _appLogger.logError('context not found');
    // }
  }

  Future<Either<DioException, MainV1TokenModel>> _refreshToken(
    MainV1TokenModel token,
  ) async {
    try {
      final response = await apiClient.post(
        'login/refresh_token/',
        data: {
          "refresh_token": token.refreshToken,
        },
      );

      final jsonData = jsonDecode(
        response.data,
      );

      final freshToken = MainV1TokenModel.fromJson(
        jsonData,
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
      _token!,
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
        await _localStorage.deleteToken();
        await _localStorage.setToken(token);

        _token = token;

        for (final requestNeedRetry in _requestsNeedRetry) {
          final headers = requestNeedRetry.options.headers;

          headers['Authorization'] = 'Bearer ${token.accessToken}';

          final newOptions = requestNeedRetry.options.copyWith(
            headers: headers,
          );

          try {
            final response = await apiClient.fetch(
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
    // final ignoreAuth = _skipPaths.contains(
    //   options.uri.path,
    // );

    // if (ignoreAuth) {
    //   return handler.next(options);
    // }

    // _token = await _localStorage.getToken();

    // if (_token is RTTokenModel && !_token!.isAccessTokenAlive) {
    //   await _refreshTokenProcess(handler).then(
    //     (_) => handler.next(
    //       options,
    //     ),
    //   );
    // }

    // final headers = options.headers;
    // headers['Authorization'] = 'Bearer ${_token?.accessToken}';

    // final newOptions = options.copyWith(headers: headers);

    return handler.next(
      options,
      // newOptions,
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // _token = await _localStorage.getToken();

    // final response = err.response;

    // if (_shouldRefreshToken(err)) {
    //   if (_token is! RTTokenModel) {
    //     return await _forceLogout(
    //       reason: 'refresh token not found',
    //     );
    //   }

    //   _requestsNeedRetry.add(
    //     (
    //       options: response!.requestOptions,
    //       handler: handler,
    //     ),
    //   );

    //   await _refreshTokenProcess(handler);
    // } else {
    handler.next(err);
    // }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) =>
      handler.next(response);
}
