import 'package:go_router/go_router.dart';

import 'base_client.dart';

final class MainApiV1Client extends BaseApiClient {
  MainApiV1Client({
    required super.environment,
    required GoRouter appRouter,
  }) : super(
          baseUrl: environment.baseUrl,
        );
}
