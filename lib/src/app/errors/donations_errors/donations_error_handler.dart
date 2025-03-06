part of 'donations_errors.dart';

class DonationsErrorHandler extends ErrorHandler {
  const DonationsErrorHandler();

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
