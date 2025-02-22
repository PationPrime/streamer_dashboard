import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/api_client/client/client.dart';

import 'app_window_manager/app_window_manager.dart';
import 'design_system/design_system.dart';
import 'global_scroll_notification_observer/global_scroll_notification_observer.dart';

class StreamerDashboardApp extends StatelessWidget {
  final GoRouter router;
  final ConcreteApiClient apiClient;

  const StreamerDashboardApp({
    super.key,
    required this.router,
    required this.apiClient,
  });

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AppThemeController>(
            create: (context) => AppThemeController(),
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
