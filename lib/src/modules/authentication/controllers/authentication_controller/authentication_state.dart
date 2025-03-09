part of 'authentication_controller.dart';

class AuthenticationState extends Equatable {
  final bool isTwitchConnected;
  final bool isTwitchConneting;
  final Failure? twitchConnetionFailure;

  bool get anyAuthenticationInProgress => isTwitchConneting;

  const AuthenticationState({
    this.isTwitchConnected = false,
    this.isTwitchConneting = false,
    this.twitchConnetionFailure,
  });

  @override
  List<Object?> get props => [
        isTwitchConnected,
        isTwitchConneting,
        twitchConnetionFailure,
      ];

  AuthenticationState copyWith({
    bool? isTwitchConnected,
    bool? isTwitchConneting,
    Failure? twitchConnetionFailure,
  }) =>
      AuthenticationState(
        isTwitchConnected: isTwitchConnected ?? this.isTwitchConnected,
        isTwitchConneting: isTwitchConneting ?? this.isTwitchConneting,
        twitchConnetionFailure:
            twitchConnetionFailure ?? this.twitchConnetionFailure,
      );

  AuthenticationState clearTwitchConnectionFailure() => copyWith(
        isTwitchConnected: isTwitchConnected,
        isTwitchConneting: isTwitchConneting,
      );
}

final class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}
