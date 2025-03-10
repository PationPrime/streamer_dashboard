import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/pages.dart';
import 'navigation_path.dart';
import 'dart:html' as html;

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream() {
    html.window.onPopState.listen((event) {
      notifyListeners();
    });
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppGoRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${NavigationPath.main}',
    errorBuilder: (context, state) => NotFound404(),
    refreshListenable: GoRouterRefreshStream(),
    routes: [
      GoRoute(
        name: NavigationPath.main,
        path: '/${NavigationPath.main}',
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
