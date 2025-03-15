part of 'twitch_streamer_account_controller.dart';

class TwitchStreamerAccountState extends Equatable {
  final bool loading;
  final Failure? failure;
  final TwitchUserModel? profileModel;

  const TwitchStreamerAccountState({
    this.loading = false,
    this.failure,
    this.profileModel,
  });

  @override
  List<Object?> get props => [
        loading,
        failure,
        profileModel,
      ];

  TwitchStreamerAccountState copyWith({
    bool? loading,
    Failure? failure,
    TwitchUserModel? profileModel,
  }) =>
      TwitchStreamerAccountState(
        loading: loading ?? this.loading,
        failure: failure ?? this.failure,
        profileModel: profileModel ?? this.profileModel,
      );

  TwitchStreamerAccountState clearFailure() => TwitchStreamerAccountState(
        loading: loading,
        profileModel: profileModel,
      );
}

final class TwitchStreamerProfileInitialState
    extends TwitchStreamerAccountState {
  const TwitchStreamerProfileInitialState();
}
