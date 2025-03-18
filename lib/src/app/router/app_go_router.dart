part of 'app_router_provider.dart';

class _AppGoRouter {
  static final dashboardPageNavKey = GlobalKey<NavigatorState>();
  static final donationsPageNavKey = GlobalKey<NavigatorState>();
  static final liveStreamsPageNavKey = GlobalKey<NavigatorState>();
  static final authenticationPageNavKey = GlobalKey<NavigatorState>();
  static final accountsPageNavKey = GlobalKey<NavigatorState>();
  static final chatbotPageNavKey = GlobalKey<NavigatorState>();
  static final streamWidgetsPageNavKey = GlobalKey<NavigatorState>();
  static final settingsPageNavKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: NavigatorKeyProvider.instance,
    initialLocation: NavigationPath.root,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) => RootWrapperRoute(
          child: navShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: dashboardPageNavKey,
            routes: [
              GoRoute(
                path: NavigationPath.root,
                name: NavigationPath.root,
                pageBuilder: (context, state) => FadeInPage(
                  child: const DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: donationsPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.donations,
                path: "/${NavigationPath.donations}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const DonationsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: liveStreamsPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.liveStreams,
                path: "/${NavigationPath.liveStreams}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const LiveStreamsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: authenticationPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.authentication,
                path: "/${NavigationPath.authentication}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const AuthenticationScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: accountsPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.accounts,
                path: "/${NavigationPath.accounts}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const AccountsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: chatbotPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.chatBot,
                path: "/${NavigationPath.chatBot}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const TwitchChatbotScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: streamWidgetsPageNavKey,
            routes: [
              GoRoute(
                name: NavigationPath.streamWidgets,
                path: "/${NavigationPath.streamWidgets}",
                pageBuilder: (context, state) => FadeInPage(
                  child: const StreamWidgetsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsPageNavKey,
            routes: [
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
      ),
    ],
  );
}
