import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/errors/constants/constants.dart';
import 'package:streamer_dashboard/src/app/failure/failure.dart';
import 'package:streamer_dashboard/src/app/repositories/repositories.dart';
import 'package:streamer_dashboard/src/app/storage/storage.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

import '../../../../app/dto/dto.dart';
import '../../../../app/tools/tools.dart';

part 'authentication_state.dart';

class AuthenticationController extends Cubit<AuthenticationState> {
  late final _appLogger = AppLogger(where: '$this');

  late TwitchLoginDto _twitchLoginDto;

  final AuthenticationRepositoryInterface _repositoryInterface;

  final LocalStorageInterface _localStorageInterface;

  AuthenticationController(
    this._repositoryInterface,
    this._localStorageInterface,
  ) : super(
          const AuthenticationInitialState(),
        ) {
    _init();
  }

  Future<void> _init() async {
    await _loadTwitchAuthData();
  }

  Future<void> _loadTwitchAuthData() async {
    try {
      final data = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.twitchAppData,
      );

      _twitchLoginDto = TwitchLoginDto.fromAdditionalData(
        data,
      );

      emit(
        const AuthenticationState(),
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error loading Twitch auth data: $error',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> forceCloseCEF() async {
    _repositoryInterface.cancelWebViewEventsSubscription();

    await _repositoryInterface.externalWebviewWindowPlugin
        .closeCEFWebViewWindow();
  }

  Future<void> loginTwitchOAuth2({
    VoidCallback? onSuccessCallback,
    VoidCallback? onFailureCallback,
  }) async {
    if (state.twitchConnetionFailure is Failure) {
      emit(
        state.clearTwitchConnectionFailure(),
      );
    }

    final response = await _repositoryInterface.loginOAuth2Twitch(
      twitchLoginDto: _twitchLoginDto,
      onLoadEnd: (uri) async {
        if ("$uri".startsWith(_twitchLoginDto.redirectUri)) {
          final queryParameters = uri.queryParameters;

          if (!queryParameters.containsKey('code') ||
              queryParameters['code'] == null) {
            _appLogger.logError(
              "code field does not exist or it's value is null",
            );
          } else {
            await _repositoryInterface.externalWebviewWindowPlugin
                .closeCEFWebViewWindow();

            _repositoryInterface.cancelWebViewEventsSubscription();

            /// Now login via Twitch with auth code
            await _loginTwitch(
              authCode: queryParameters['code']!,
              onSuccessCallback: onSuccessCallback,
              onFailureCallback: onFailureCallback,
            );
          }
        }
      },
    );

    response.fold(
      (failure) {
        _appLogger.logError(
          'loginTwitchOAuth2 login failure: ${failure.message}',
          stackTrace: failure.stackTrace,
          lexicalScope: 'loginTwitchOAuth2 method',
        );

        emit(
          state.copyWith(
            twitchConnetionFailure: failure,
          ),
        );
      },
      (success) => emit(
        state.copyWith(
          isTwitchConneting: false,
        ),
      ),
    );
  }

  Future<void> _loginTwitch({
    required String authCode,
    VoidCallback? onSuccessCallback,
    VoidCallback? onFailureCallback,
  }) async {
    emit(
      state.copyWith(
        isTwitchConneting: true,
      ),
    );

    _twitchLoginDto = _twitchLoginDto.copyWith(
      code: authCode,
      grantType: TwitchConstants.authorizationCodeGrantType,
    );

    final response = await _repositoryInterface.loginTwitch(
      twitchLoginDto: _twitchLoginDto,
    );

    response.fold(
      (failure) {
        _appLogger.logError(
          'Twitch login failure: ${failure.message}',
          stackTrace: failure.stackTrace,
        );

        emit(
          state.copyWith(
            isTwitchConneting: false,
            twitchConnetionFailure: failure,
          ),
        );

        onFailureCallback?.call();
      },
      (twitchTokenModel) async {
        _appLogger.logArgsList(
          {
            'twitch TOKEN': twitchTokenModel,
          },
        );

        try {
          await _localStorageInterface.setTwitchToken(
            twitchTokenModel,
          );

          emit(
            state.copyWith(
              isTwitchConnected: true,
            ),
          );

          onSuccessCallback?.call();
        } catch (error, stackTrace) {
          _appLogger.logError(
            'Failed to set Twitch token: $error',
            stackTrace: stackTrace,
          );

          emit(
            state.copyWith(
              isTwitchConnected: false,
              twitchConnetionFailure: OtherFailure(
                message: 'Failed to set Twitch token: $error',
                stackTrace: stackTrace,
              ),
            ),
          );

          onFailureCallback?.call();
        } finally {
          emit(
            state.copyWith(
              isTwitchConneting: false,
            ),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    _appLogger.logMessage(
      'AuthenticationController Close',
    );

    return super.close();
  }
}
