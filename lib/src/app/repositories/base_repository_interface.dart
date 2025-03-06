import 'package:flutter/foundation.dart';

import '../api_client/client/concrete_client.dart';
import '../errors/errors.dart';

abstract interface class BaseRepositoryInterface {
  @protected
  ErrorHandler get errorHandler;

  @protected
  ConcreteApiClient get apiClient;
}
