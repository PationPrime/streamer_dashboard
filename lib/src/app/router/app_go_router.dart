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
            pageBuilder: (context, state) => FadeInPage(
              child: const DashboardScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.donations,
            path: "/${NavigationPath.donations}",
            pageBuilder: (context, state) => FadeInPage(
              child: const DonationsScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.liveStreams,
            path: "/${NavigationPath.liveStreams}",
            pageBuilder: (context, state) => FadeInPage(
              child: const LiveStreamsScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.authentication,
            path: "/${NavigationPath.authentication}",
            pageBuilder: (context, state) => FadeInPage(
              child: const AuthenticationScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.accounts,
            path: "/${NavigationPath.accounts}",
            pageBuilder: (context, state) => FadeInPage(
              child: const AccountsScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.streamWidgets,
            path: "/${NavigationPath.streamWidgets}",
            pageBuilder: (context, state) => FadeInPage(
              child: const StreamWidgetsScreen(),
            ),
          ),
          GoRoute(
            name: NavigationPath.settings,
            path: "/${NavigationPath.settings}",
            pageBuilder: (context, state) => FadeInPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
