import 'package:flutter/foundation.dart';

import '../../failure/failure.dart';
import '../api/api_errors.dart';
import '../constants/constants.dart';

class AppErrorHandler extends ErrorHandler {
  const AppErrorHandler();

  @protected
  @override
  Map<String, Failure Function(ApiError)> get errorCodeToFailure => {
        "other_error": (ApiError apiError) => OtherFailure(
              message: apiError.message,
              stackTrace: apiError.stackTrace,
              response: apiError.rawBody,
              dioException: apiError.dioException,
            ),
      };

  @override
  List<String> get connectionTimeoutExcludedUris => [];
}
