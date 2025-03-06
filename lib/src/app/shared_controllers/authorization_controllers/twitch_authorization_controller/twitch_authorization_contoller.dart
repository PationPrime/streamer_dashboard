import 'dart:async';

import 'package:streamer_dashboard/src/app/models/models.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';

import '../../../errors/constants/constants.dart';

part 'twitch_authorization_state.dart';

class TwitchAuthorizationContoller extends BaseAuthorizationController {
  late final _appLogger = AppLogger(where: '$this');

  TwitchAuthorizationContoller({
    required super.localStorageInterface,
  }) {
    chechAuthorizationState();
  }

  @override
  FutureOr<void> chechAuthorizationState() async {
    try {
      final twitchTokenModel = await localStorageInterface.getTwitchToken();

      if (twitchTokenModel is! TwitchTokenModel ||
          twitchTokenModel.accessToken.isEmpty ||
          twitchTokenModel.expiresIn <= 0 ||
          twitchTokenModel.refreshToken.isEmpty) {
        emit(
          const Unauthorized(),
        );
      } else {
        emit(
          const Authorized(),
        );
      }
    } catch (error, stackTrace) {
      _appLogger.logError(
        'chechAuthorizationState error: $error',
        stackTrace: stackTrace,
        lexicalScope: 'chechAuthorizationState method',
      );

      emit(
        AuthorizationFailed(
          TwitchAuthorizationCheckFailure(
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  @override
  FutureOr<void> signOut() {
    emit(Unauthorized());
  }
}
