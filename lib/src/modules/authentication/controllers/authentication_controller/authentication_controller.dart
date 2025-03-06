import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/failure/failure.dart';
import 'package:streamer_dashboard/src/app/repositories/repositories.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

import '../../../../app/dto/dto.dart';
import '../../../../app/tools/tools.dart';

part 'authentication_state.dart';

class AuthenticationController extends Cubit<AuthenticationState> {
  late final _appLogger = AppLogger(where: '$this');

  late final TwitchLoginDto _twitchLoginDto;

  final AuthenticationRepositoryInterface _repositoryInterface;

  AuthenticationController(
    this._repositoryInterface,
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
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error loading Twitch auth data: $error',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> loginTwitch({
    required String authCode,
  }) async {
    if (state.twitchConnetionFailure is Failure) {
      emit(
        state.clearTwitchConnectionFailure(),
      );
    }

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
          stackTrace: failure.stackTrace ?? StackTrace.current,
        );

        emit(
          state.copyWith(
            isTwitchConneting: false,
            twitchConnetionFailure: failure,
          ),
        );
      },
      (twitchTokenModel) => emit(
        state.copyWith(
          isTwitchConnected: true,
          isTwitchConneting: false,
        ),
      ),
    );
  }
}
