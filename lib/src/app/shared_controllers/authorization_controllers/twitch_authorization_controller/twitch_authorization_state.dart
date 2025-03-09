part of 'twitch_authorization_controller.dart';

final class TwitchAuthorizationInitialState
    extends BaseAuthorizationInitialState {}

final class Authorized extends BaseAuthorized {
  const Authorized();
}

final class Unauthorized extends BaseUnauthorized {
  const Unauthorized();
}

final class AuthorizationFailed extends BaseAuthorizationFailed {
  const AuthorizationFailed(
    super.failure,
  );

  @override
  List<Object> get props => [
        failure,
      ];
}
