part of 'authentication_controller.dart';

class AuthenticationState extends Equatable {
  final bool isTwitchConnected;
  final bool isTwitchConneting;
  final Failure? twitchConnetionFailure;
  final Uri? twitchOAuth2Uri;

  bool get anyAuthenticationInProgress => isTwitchConneting;

  const AuthenticationState({
    this.isTwitchConnected = false,
    this.isTwitchConneting = false,
    this.twitchConnetionFailure,
    this.twitchOAuth2Uri,
  });

  @override
  List<Object?> get props => [
        isTwitchConnected,
        isTwitchConneting,
        twitchConnetionFailure,
        twitchOAuth2Uri,
      ];

  AuthenticationState copyWith({
    bool? isTwitchConnected,
    bool? isTwitchConneting,
    Failure? twitchConnetionFailure,
    Uri? twitchOAuth2Uri,
  }) =>
      AuthenticationState(
        isTwitchConnected: isTwitchConnected ?? this.isTwitchConnected,
        isTwitchConneting: isTwitchConneting ?? this.isTwitchConneting,
        twitchConnetionFailure:
            twitchConnetionFailure ?? this.twitchConnetionFailure,
        twitchOAuth2Uri: twitchOAuth2Uri ?? this.twitchOAuth2Uri,
      );

  AuthenticationState clearTwitchConnectionFailure() => copyWith(
        isTwitchConnected: isTwitchConnected,
        isTwitchConneting: isTwitchConneting,
        twitchOAuth2Uri: twitchOAuth2Uri,
      );
}

final class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}
