part of 'twitch_live_stream_controller.dart';

class TwitchLiveStreamState extends Equatable {
  final String? chatUrl;
  final bool loading;
  final Failure? failure;

  const TwitchLiveStreamState({
    this.chatUrl,
    this.loading = false,
    this.failure,
  });

  @override
  List<Object?> get props => [
        chatUrl,
        loading,
        failure,
      ];

  TwitchLiveStreamState copyWith({
    String? chatUrl,
    bool? loading,
    Failure? failure,
  }) =>
      TwitchLiveStreamState(
        chatUrl: chatUrl ?? this.chatUrl,
        loading: loading ?? this.loading,
        failure: failure ?? this.failure,
      );

  TwitchLiveStreamState clearFailure() => TwitchLiveStreamState(
        chatUrl: chatUrl,
        loading: loading,
      );
}

final class TwitchLiveStreamInitialState extends TwitchLiveStreamState {
  const TwitchLiveStreamInitialState();
}
