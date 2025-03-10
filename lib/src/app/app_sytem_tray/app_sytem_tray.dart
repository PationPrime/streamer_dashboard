import 'dart:io';

import 'package:external_webview_window/external_webview_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/router/app_router_provider.dart';
import 'package:streamer_dashboard/src/modules/stream_widgets/controllers/stream_widgets_controller/stream_widgets_controller.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

import '../../assets_gen/assets.gen.dart';
import '../tools/app_logger.dart';

abstract final class AppSystemTray {
  static final _systemTray = SystemTray();
  static final _externalWebviewWindowPlugin = ExternalWebviewWindow();

  static const _appLogger = AppLogger(
    where: 'AppSystemTray',
  );

  static final _menu = Menu();

  static Future<void> _initSystemTray() async {
    final iconPath = Platform.isWindows
        ? Assets.appLogo.appLogoIco
        : Assets.appLogo.appLogoPng.path;

    await _systemTray.initSystemTray(
      iconPath: iconPath,
    );

    _systemTray.registerSystemTrayEventHandler(
      (eventName) {
        if (eventName == kSystemTrayEventClick) {
          _systemTray.popUpContextMenu();
        } else if (eventName == kSystemTrayEventRightClick) {
          _systemTray.popUpContextMenu();
        }
      },
    );

    await _menu.buildFrom(
      [
        MenuItemLabel(
          label: 'Expand',
          onClicked: (_) => windowManager.show(),
        ),
        MenuItemLabel(
          label: 'Collapse',
          onClicked: (_) => windowManager.hide(),
        ),
        MenuSeparator(),
        MenuItemLabel(
          label: 'Close',
          onClicked: (_) async {
            try {
              /// Closing CEF before app shuts down
              await _externalWebviewWindowPlugin.closeCEFWebViewWindow();

              /// Shut down Stream Widgets hosting
              final context = AppRouterProvider
                  .instance.routerDelegate.navigatorKey.currentContext;

              if (context is BuildContext) {
                if (!context.mounted) return;
                context.read<StreamWidgetsController>().shutdownServer();
              }
            } catch (error, stackTrace) {
              _appLogger.logError(
                'Failed to release all dependent resources before closing the application: $error',
                stackTrace: stackTrace,
              );
            } finally {
              await windowManager.close();
            }
          },
        ),
      ],
    );

    await _systemTray.setContextMenu(_menu);
  }

  static Future<void> init() async {
    if (kIsWeb || (!Platform.isWindows && !Platform.isLinux)) return;
    await _initSystemTray();
  }
}
