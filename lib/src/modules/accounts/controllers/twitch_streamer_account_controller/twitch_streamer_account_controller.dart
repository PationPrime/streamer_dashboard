import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';
import 'package:streamer_dashboard/src/app/repositories/repositories.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';

import '../../../../app/failure/failure.dart';

part 'twitch_streamer_account_state.dart';

class TwitchStreamerAccountController
    extends Cubit<TwitchStreamerAccountState> {
  late final _appLogger = AppLogger(where: '$this');

  final TwitchApiRepositoryInterface _twitchApiRepositoryInterface;

  TwitchStreamerAccountController(
    this._twitchApiRepositoryInterface,
  ) : super(
          const TwitchStreamerProfileInitialState(),
        );

  void clearProfileState() => emit(
        const TwitchStreamerAccountState(),
      );

  Future<void> getStreamerProfile() async {
    _appLogger.logMessage('Get Twitch Profile');

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
