import 'package:dio/dio.dart';
import 'package:streamer_dashboard/src/app/api_client/client/twitch_api_client.dart';

import '../../config/environment/environment.dart';
import '../../router/app_router_provider.dart';
import 'main_api_v1_client.dart';
import 'interceptors/interceptors.dart';
import 'twitch_auth_client.dart';

final class ConcreteApiClient {
  static final _instance = ConcreteApiClient._();

  factory ConcreteApiClient.singleton() => _instance;

  late MainApiV1Client mainApiV1ClientInstance;
  late TwitchAuthClient twitchAuthClientInstance;
  late TwitchApiClient twitchApiClientInstance;

  late Dio mainApiV1Client;
  late Dio twitchAuthClient;
  late Dio twitchApiClient;

  ConcreteApiClient._() {
    setupApiClient();
  }

  void setupApiClient() {
    final environment = AppEnvironment.instance;

    mainApiV1ClientInstance = MainApiV1Client(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    twitchAuthClientInstance = TwitchAuthClient(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    twitchApiClientInstance = TwitchApiClient(
      environment: environment,
      appRouter: AppRouterProvider.instance,
    );

    mainApiV1Client = mainApiV1ClientInstance.apiClient
      ..interceptors.addAll(
        [
          QueuedMainAuthInterceptor(
            baseUrl: environment.baseUrl,
            appRouter: AppRouterProvider.instance,
            apiClient: mainApiV1ClientInstance.apiClient,
          ),
          QueuedRetryInterceptor(),
        ],
      );

    twitchAuthClient = twitchAuthClientInstance.apiClient;

    twitchApiClient = twitchApiClientInstance.apiClient
      ..interceptors.addAll(
        [
          QueuedTwitchAuthInterceptor(
            baseUrl: environment.twitchApiBaseUrl,
            appRouter: AppRouterProvider.instance,
            twitchApiClient: twitchApiClientInstance.apiClient,
            twitchAuthClient: twitchAuthClient,
          ),
        ],
      );
  }
}
