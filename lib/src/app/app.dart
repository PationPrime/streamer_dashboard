import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/authorization_controllers/twitch_authorization_controller/twitch_authorization_controller.dart';
import 'package:streamer_dashboard/src/app/storage/storage.dart';

import '../modules/modules.dart';
import 'api_client/client/concrete_client.dart';
import 'app_window_manager/app_window_manager.dart';
import 'design_system/design_system.dart';
import 'global_scroll_notification_observer/global_scroll_notification_observer.dart';
import 'repositories/repositories.dart';

class StreamerDashboardApp extends StatelessWidget {
  final GoRouter router;
  final ConcreteApiClient apiClient;
  final Map<String, BaseRepositoryInterface> repositories;
  final AppSecureStorage appSecureStorage;

  const StreamerDashboardApp({
    super.key,
    required this.router,
    required this.apiClient,
    required this.repositories,
    required this.appSecureStorage,
  });

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DonationsRepositoryInterface>(
            create: (_) => repositories['donations'] as DonationsRepository,
          ),
          RepositoryProvider<AuthenticationRepositoryInterface>(
            create: (_) =>
                repositories['authentication'] as AuthenticationRepository,
          ),
          RepositoryProvider<TwitchApiRepositoryInterface>(
            create: (_) => repositories['twitch_api'] as TwitchApiRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppThemeController>(
              create: (context) => AppThemeController(),
            ),
            BlocProvider<DonationsController>(
              create: (context) => DonationsController(),
            ),
            BlocProvider<TwitchAuthorizationController>(
              create: (context) => TwitchAuthorizationController(
                localStorageInterface: appSecureStorage,
              ),
            ),
            BlocProvider<AuthenticationController>(
              create: (context) => AuthenticationController(
                context.read<AuthenticationRepositoryInterface>(),
                appSecureStorage,
              ),
            ),
            BlocProvider<TwitchStreamerProfileController>(
              create: (context) => TwitchStreamerProfileController(
                context.read<TwitchApiRepositoryInterface>(),
              ),
            ),
          ],
          child: GlobalScrollNotificationObserver(
            child: BlocBuilder<AppThemeController, AppThemeState>(
              builder: (context, appThemeState) => AppThemeConfig(
                type: appThemeState.themeType,
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: _StreamerDashboardAppView(
                    router: router,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _StreamerDashboardAppView extends StatefulWidget {
  final GoRouter router;

  const _StreamerDashboardAppView({
    required this.router,
  });

  @override
  State<_StreamerDashboardAppView> createState() =>
      _StreamerDashboardAppViewState();
}

class _StreamerDashboardAppViewState extends State<_StreamerDashboardAppView> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        builder: (context, child) => ScrollConfiguration(
          behavior: const _AppScrollBehavior(),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(
                1.0,
              ),
            ),
            child: AppWindowManager(
              child: ClipRRect(
                borderRadius: Platform.isWindows
                    ? BorderRadius.circular(8.0)
                    : Platform.isLinux
                        ? BorderRadius.circular(6.0)
                        : BorderRadius.circular(8.0),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),

        // locale: context.locale,
        // supportedLocales: context.supportedLocales,
        // localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context),
        darkTheme: AppThemeData.darkTheme,
        title: 'Streamer Dashboard',
        routerConfig: widget.router,
      );
}

/// Конфигурация скролла
class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
