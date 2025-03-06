part of 'authentication_errors.dart';

class AuthenticationErrorHandler extends ErrorHandler {
  const AuthenticationErrorHandler();

  @protected
  @override
  Map<String, Failure Function(ApiError)> get errorCodeToFailure => {
        'other_error': (ApiError apiError) => OtherFailure(
              message: apiError.message,
              stackTrace: apiError.stackTrace,
              response: apiError.rawBody,
              dioException: apiError.dioException,
            ),
      };
}
