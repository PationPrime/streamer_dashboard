import 'package:dio/dio.dart';

import '../../../router/app_router_provider.dart';
import '../../../tools/tools.dart';
import '../failed_request.dart';

class QueuedRetryInterceptor extends QueuedInterceptor {
  final _logger = const AppLogger(where: 'QueuedRetryInterceptor');
  static final appRouter = AppRouterProvider.instance;

  QueuedRetryInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failedRequest = RTFailedAPIRequest(
      err,
      handler,
    );

    _logger.logError(
      'Failed request error: ${failedRequest.error}',
    );
  }
}
