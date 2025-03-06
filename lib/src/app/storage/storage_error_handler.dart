import 'package:flutter/foundation.dart';

import '../errors/constants/constants.dart';
import '../errors/errors.dart';
import '../failure/failure.dart';

class StorageErrorHandler extends ErrorHandler {
  const StorageErrorHandler();

  @protected
  @override
  Map<String, Failure Function(ApiError)> get errorCodeToFailure => {
        "other_error": (ApiError apiError) => OtherFailure(
              message: apiError.message,
            ),
      };

  @override
  List<String> get connectionTimeoutExcludedUris => [];
}
