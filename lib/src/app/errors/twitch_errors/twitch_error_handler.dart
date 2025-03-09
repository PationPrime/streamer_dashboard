part of 'twitch_errors.dart';

class TwitchErrorHandler extends ErrorHandler {
  const TwitchErrorHandler();

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

  @override
  List<String> get connectionTimeoutExcludedUris => [];
}
