import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../config/environment/environment.dart';
import '../../router/app_router_provider.dart';
import 'base_client.dart';
import 'interceptors/interceptors.dart';

final class ApiV1 extends ApiClient {
  ApiV1({
    required super.environment,
    required GoRouter appRouter,
  }) : super(
          baseUrl: environment.baseUrl,
        );
}

final class ConcreteApiClient {
  static final _instance = ConcreteApiClient._();

  late Dio v1;

  factory ConcreteApiClient.singleton() => _instance;

  ConcreteApiClient._() {
    setupApiClient();
  }

  void setupApiClient() {
    final environment = AppEnvironment.instance;

    final v1Instance = ApiV1(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    v1 = v1Instance.apiClient
      ..interceptors.addAll(
        [
          QueuedAuthInterceptor(
            baseUrl: environment.baseUrl,
            appRouter: AppRouterProvider.instance,
            apiClient: v1Instance.apiClient,
          ),
          QueuedRetryInterceptor(),
        ],
      );
  }
}
