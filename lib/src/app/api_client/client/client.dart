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

final class TwtitchApiV1 extends ApiClient {
  TwtitchApiV1({
    required super.environment,
    required GoRouter appRouter,
  }) : super(
          baseUrl: environment.twitchAuthBaseUrl,
        );
}

final class ConcreteApiClient {
  static final _instance = ConcreteApiClient._();

  late Dio mainV1;

  late Dio twitchApiV1;

  factory ConcreteApiClient.singleton() => _instance;

  ConcreteApiClient._() {
    setupApiClient();
  }

  void setupApiClient() {
    final environment = AppEnvironment.instance;

    final mainV1Instance = ApiV1(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    final twitchV1Instance = TwtitchApiV1(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    mainV1 = mainV1Instance.apiClient
      ..interceptors.addAll(
        [
          QueuedMainAuthInterceptor(
            baseUrl: environment.baseUrl,
            appRouter: AppRouterProvider.instance,
            apiClient: mainV1Instance.apiClient,
          ),
          QueuedRetryInterceptor(),
        ],
      );

    twitchApiV1 = twitchV1Instance.apiClient
      ..interceptors.addAll(
        [
          QueuedTwitchAuthInterceptor(
            baseUrl: environment.twitchAuthBaseUrl,
            appRouter: AppRouterProvider.instance,
            apiClient: twitchV1Instance.apiClient,
          ),
        ],
      );
  }
}
