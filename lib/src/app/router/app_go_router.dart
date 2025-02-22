part of 'app_router_provider.dart';

class _AppGoRouter {
  static final router = GoRouter(
    navigatorKey: NavigatorKeyProvider.instance,
    initialLocation: NavigationPath.root,
    routes: [
      ShellRoute(
        builder: (context, state, child) => RootWrapperRoute(
          child: child,
        ),
        routes: [
          GoRoute(
            path: NavigationPath.root,
            name: NavigationPath.root,
            pageBuilder: (context, state) => MaterialPage(
              child: const DashboardScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.settings,
            path: "/${NavigationPath.settings}",
            pageBuilder: (context, state) => MaterialPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
