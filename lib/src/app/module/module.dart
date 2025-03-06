import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:streamer_dashboard/src/app/api_client/client/client.dart';
import 'package:streamer_dashboard/src/app/app.dart';
import 'package:streamer_dashboard/src/app/router/app_router_provider.dart';
import 'package:streamer_dashboard/src/app/tools/app_logger.dart';
import 'package:window_manager/window_manager.dart';

import '../app_sytem_tray/app_sytem_tray.dart';
import '../repositories/repositories.dart';
import '../storage/storage.dart';

abstract final class AppModule {
  static final _apiClient = ConcreteApiClient.singleton();
  static final _secureLocalStorage = AppSecureStorage.instance;
  static final _router = AppRouterProvider.instance;
  static const _appLogger = AppLogger(where: 'AppModule');

  static final Map<String, BaseRepositoryInterface> _repositories = {
    'donations': DonationsRepository(),
    'authentication': AuthenticationRepository(
      _apiClient,
      _secureLocalStorage,
    ),
  };

  static Future<void> init() async {
    await runZonedGuarded(
      () async {
        await _configureDependencies();
        await _initLocalStorage();
        await _initLocalization();

        await AppSystemTray.init();

        runApp(
          StreamerDashboardApp(
            router: _router,
            apiClient: _apiClient,
            repositories: _repositories,
          ),
        );
      },
      (error, stackTrace) {
        PlatformDispatcher.instance.onError = (error, stackTrace) {
          _appLogger.logError(
            'PlatformDispatcher Error: $error',
            stackTrace: stackTrace,
          );

          return true;
        };

        _appLogger.logError(
          'runZonedGuarded Error: $error',
          stackTrace: stackTrace,
        );
      },
    );
  }

  static Future<void> _configureDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();

    await windowManager.ensureInitialized();
    Window.initialize();
    Window.setEffect(effect: WindowEffect.transparent);
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setAsFrameless();
      windowManager.show();
    });
  }

  static Future<void> _initLocalStorage() async {}

  static Future<void> _initLocalization() async {}
}
