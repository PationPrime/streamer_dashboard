import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/pages.dart';
import 'navigation_path.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppGoRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => NotFound404(),
    routes: [
      GoRoute(
        name: NavigationPath.root,
        path: NavigationPath.root,
        builder: (context, state) {
          final queryParameters = state.uri.queryParameters;
          final bridgeUrl = queryParameters['bridgeUrl'];

          if (bridgeUrl == null) {
            return PathParametersError(
              pagePath: '/${NavigationPath.main}',
              queryParameters: {
                'bridgeUrl': 'String',
              },
            );
          }

          return Welcome(
            bridgeUrl: bridgeUrl,
          );
        },
      ),
      GoRoute(
        name: NavigationPath.subsGlass,
        path: '/${NavigationPath.subsGlass}',
        builder: (context, state) => const DefaultFallingBallsWidget(),
      ),
    ],
  );
}
