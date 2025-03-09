import '../../failure/failure.dart';

class OtherFailure extends Failure {
  final String errorCode;

  const OtherFailure({
    this.errorCode = 'other_error',
    super.message = 'Something went wrong',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class TwitchAuthorizationCheckFailure extends Failure {
  final String errorCode;

  const TwitchAuthorizationCheckFailure({
    this.errorCode = 'twitch_authorization_check_error',
    super.message = 'Twitch authorization check failed',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class Code400Failure extends Failure {
  final String errorCode;

  const Code400Failure({
    this.errorCode = 'bad_request',
    super.message = 'Bad request',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class Code404Failure extends Failure {
  final String errorCode;

  const Code404Failure({
    this.errorCode = 'not_found',
    super.message = 'Not found',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class Code500Failure extends Failure {
  final String? errorCode;

  const Code500Failure({
    this.errorCode = 'server_error',
    super.message = 'Internal error',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          code: errorCode,
        );
}

class ConnectionTimeOutFailure extends Failure {
  final String? errorCode;

  const ConnectionTimeOutFailure({
    this.errorCode = 'connection_timeout',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          message: 'Connection error',
          code: errorCode,
        );
}

class ConnectionErrorFailure extends Failure {
  final String? errorCode;

  const ConnectionErrorFailure({
    this.errorCode = 'connection_error',
    super.stackTrace,
    super.response,
    super.dioException,
  }) : super(
          message: 'connection error',
          code: errorCode,
        );
}
