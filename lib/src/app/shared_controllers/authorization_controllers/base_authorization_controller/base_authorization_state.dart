part of 'base_authorization_controller.dart';

abstract class BaseAuthorizationState extends Equatable {
  const BaseAuthorizationState();

  @override
  List<Object> get props => [];
}

class BaseAuthorizationInitialState extends BaseAuthorizationState {
  const BaseAuthorizationInitialState();
}

abstract class BaseAuthorized extends BaseAuthorizationState {
  const BaseAuthorized();
}

abstract class BaseUnauthorized extends BaseAuthorizationState {
  const BaseUnauthorized();
}

abstract class BaseAuthorizationFailed extends BaseAuthorizationState {
  final Failure failure;

  String get failureMessage => failure.message;

  const BaseAuthorizationFailed(
    this.failure,
  );

  @override
  List<Object> get props => [
        failure,
      ];
}
