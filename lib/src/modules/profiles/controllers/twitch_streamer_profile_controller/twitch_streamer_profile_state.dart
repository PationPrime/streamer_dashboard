part of 'twitch_streamer_profile_controller.dart';

class TwitchStreamerProfileState extends Equatable {
  final bool loading;
  final Failure? failure;
  final TwitchUserModel? profileModel;

  const TwitchStreamerProfileState({
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

  TwitchStreamerProfileState copyWith({
    bool? loading,
    Failure? failure,
    TwitchUserModel? profileModel,
  }) =>
      TwitchStreamerProfileState(
        loading: loading ?? this.loading,
        failure: failure ?? this.failure,
        profileModel: profileModel ?? this.profileModel,
      );

  TwitchStreamerProfileState clearFailure() => TwitchStreamerProfileState(
        loading: loading,
        profileModel: profileModel,
      );
}

final class TwitchStreamerProfileInitialState
    extends TwitchStreamerProfileState {
  const TwitchStreamerProfileInitialState();
}
