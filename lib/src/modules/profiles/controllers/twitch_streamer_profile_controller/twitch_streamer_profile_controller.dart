import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';
import 'package:streamer_dashboard/src/app/repositories/repositories.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';

import '../../../../app/failure/failure.dart';

part 'twitch_streamer_profile_state.dart';

class TwitchStreamerProfileController
    extends Cubit<TwitchStreamerProfileState> {
  late final _appLogger = AppLogger(where: '$this');

  final TwitchApiRepositoryInterface _twitchApiRepositoryInterface;

  TwitchStreamerProfileController(
    this._twitchApiRepositoryInterface,
  ) : super(
          const TwitchStreamerProfileInitialState(),
        ) {
    getStreamerProfile();
  }

  void clearProfileState() => emit(
        const TwitchStreamerProfileState(),
      );

  Future<void> getStreamerProfile() async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    final response = await _twitchApiRepositoryInterface.getStreamerProfile();

    response.fold(
      (failure) {
        _appLogger.logError(
          'Get Twitch streamer profile failed: ${failure.message}',
          stackTrace: failure.stackTrace,
        );

        emit(
          state.copyWith(
            failure: failure,
            loading: false,
          ),
        );
      },
      (profileModel) => emit(
        state.copyWith(
          profileModel: profileModel,
          loading: false,
        ),
      ),
    );
  }
}
