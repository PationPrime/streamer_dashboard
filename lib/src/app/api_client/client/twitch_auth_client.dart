import 'package:go_router/go_router.dart';

import 'base_client.dart';

final class TwitchAuthClient extends BaseApiClient {
  TwitchAuthClient({
    required super.environment,
    required GoRouter appRouter,
  }) : super(
          baseUrl: environment.twitchAuthBaseUrl,
        );
}
