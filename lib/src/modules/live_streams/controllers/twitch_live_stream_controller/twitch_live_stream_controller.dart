import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/errors/constants/constants.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';

import '../../../../app/failure/failure.dart';
import '../../../accounts/module.dart';

part 'twitch_live_stream_state.dart';

class TwitchLiveStreamController extends Cubit<TwitchLiveStreamState> {
  late final _appLogger = AppLogger(where: '$this');

  final TwitchStreamerAccountController twitchStreamerProfileController;

  TwitchLiveStreamController({
    required this.twitchStreamerProfileController,
  }) : super(
          const TwitchLiveStreamInitialState(),
        ) {
    _init();
  }

  Future<void> _init() async {
    await twitchStreamerProfileController.getStreamerProfile();

    if (isClosed) return;

    emit(
      state.copyWith(
        loading: true,
      ),
    );

    final streamerProfile = twitchStreamerProfileController.state.profileModel;

    if (streamerProfile == null) {
      _appLogger.logError(
        'streamerProfile is null',
      );

      final errorMessage = "Twitch streamer profile not found!\n"
          "Try to connect Twitch account.";

      emit(
        state.copyWith(
          failure: OtherFailure(
            message: errorMessage,
            errorCode: 'twitch_profile_not_found',
          ),
        ),
      );

      return;
    }

    final chatUrl =
        '${TwitchConstants.twitchTVUrl}/${streamerProfile.login}/chat';

    emit(
      TwitchLiveStreamState(
        chatUrl: chatUrl,
      ),
    );
  }
}
