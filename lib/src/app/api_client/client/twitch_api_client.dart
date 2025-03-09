import 'package:go_router/go_router.dart';

import 'base_client.dart';

final class TwitchApiClient extends BaseApiClient {
  TwitchApiClient({
    required super.environment,
    required GoRouter appRouter,
  }) : super(
          baseUrl: environment.twitchApiBaseUrl,
        );
}
