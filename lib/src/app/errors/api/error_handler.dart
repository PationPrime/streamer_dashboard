part of 'api_errors.dart';

final _baseErrorCode = {
  400: const Code400Failure(),
  404: const Code404Failure(),
  500: const Code500Failure(),
};

/// Базовый класс для обработки серверных ошибок
abstract class ErrorHandler {
  static final appRouter = AppRouterProvider.instance;

  /// Константный конструктор класса [ErrorHandler]
  const ErrorHandler();

  /// Карта ошибок типа [Failure]
  Map<String, Failure Function(ApiError)> get errorCodeToFailure;

  /// Хендлер ошибок типа [Failure]
  Failure handleError(dynamic error) {
    if (error is! DioException) {
      return OtherFailure(
        message: error.toString(),
      );
    }

    final extractedError = _extractError(error);

    final failureBuilder = errorCodeToFailure[extractedError.code];

    if (failureBuilder != null) {
      return failureBuilder.call(extractedError);
    } else {
      return handleUnhandledError(error);
    }
  }

  Failure handleUnhandledError(DioException error) {
    return _baseErrorCode[error.response?.statusCode] ??
        OtherFailure(
          message: error.message ?? 'unknown_error_message',
        );
  }

  /// Метод извлечения кода и сообщения из ошибок типа [DioException]
  /// и преобразование в объект [ApiError]
  ApiError _extractError(DioException error) {
    Map<String, dynamic> body = {};
    if (error.response?.data is Map) {
      body = error.response!.data;
    }
    return ApiError(
      code: body['errorCode'] ?? '${error.response?.statusCode}',
      message: body['errorMessage'] ?? error.response?.data.toString() ?? '',
      rawBody: body,
    );
  }
}
