part of 'api_errors.dart';

final Map<int, Failure Function(ApiError)> _baseErrorCodes = {
  400: (ApiError apiError) => Code400Failure(
        stackTrace: apiError.stackTrace,
        response: apiError.rawBody,
        dioException: apiError.dioException,
        message: apiError.message,
      ),
  404: (ApiError apiError) => Code404Failure(
        stackTrace: apiError.stackTrace,
        response: apiError.rawBody,
        dioException: apiError.dioException,
        message: apiError.message,
      ),
  500: (ApiError apiError) => Code500Failure(
        stackTrace: apiError.stackTrace,
        response: apiError.rawBody,
        dioException: apiError.dioException,
        message: apiError.message,
      ),
};

abstract class ErrorHandler {
  static const _appLogger = AppLogger(where: 'ErrorHandler');

  const ErrorHandler();

  Map<String, Failure Function(ApiError)> get errorCodeToFailure;

  List<String> get connectionTimeoutExcludedUris;

  void _handleConnectionFailure(Failure failure) {
    if (failure is ConnectionTimeOutFailure) {
      _appLogger.logError("${failure.code}");

      final context = NavigatorKeyProvider.instance.currentContext;

      if (context is BuildContext && context.mounted) {
        // context.read<ErrorController>().emitError(failure);
      }
    }
  }

  Failure handleError(
    dynamic error, {
    StackTrace? stackTrace,
  }) {
    if (error is! DioException) {
      return OtherFailure(
        message: "$error",
        stackTrace: stackTrace,
      );
    }

    final extractedError = _extractError(
      error,
      stackTrace,
    );

    final failureBuilder = errorCodeToFailure[extractedError.code];

    final handledError = handleUnhandledError(
      error,
      stackTrace,
    );

    _handleConnectionFailure(handledError);

    return failureBuilder is Failure Function(ApiError)
        ? failureBuilder.call(extractedError)
        : handledError;
  }

  Failure handleUnhandledError(
    DioException error, [
    StackTrace? stackTrace,
  ]) {
    final extractedError = _extractError(
      error,
      stackTrace,
    );

    _appLogger.logError('handled error type: ${error.requestOptions.uri}');

    final failure = (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout) &&
            !connectionTimeoutExcludedUris.contains(
              "${error.requestOptions.uri}",
            )
        ? ConnectionTimeOutFailure()
        : _baseErrorCodes[error.response?.statusCode]?.call(extractedError) ??
            OtherFailure(
              errorCode: error.type == DioExceptionType.connectionTimeout ||
                      error.type == DioExceptionType.receiveTimeout
                  ? 'connection_timeout'
                  : 'other_error',
              message: error.message ??
                  (error.response?.data != null
                      ? "${error.response?.data}"
                      : "Unknown error"),
              stackTrace: stackTrace,
              dioException: error,
              response: error.response?.data is Map<String, dynamic>
                  ? error.response?.data
                  : error.response?.data is String
                      ? jsonDecode(error.response?.data)
                      : null,
            );

    return failure;
  }

  ApiError _extractError(
    DioException error, [
    StackTrace? stackTrace,
  ]) {
    Map<String, dynamic> body = {};
    if (error.response?.data is Map) {
      body = error.response!.data;
    } else if (error.response?.data is String) {
      try {
        body = jsonDecode(error.response!.data);
      } catch (_) {
        ///
      }
    }

    String? type = body['errorCode'] ?? '${error.response?.statusCode}';
    String? message = body['errorMessage'] ??
        error.response?.data.toString() ??
        'Empty error message';

    return ApiError(
      code: type ?? 'Unknown error type',
      message: message ?? 'Unknown error message',
      rawBody: body,
      stackTrace: stackTrace,
      dioException: error,
    );
  }
}
