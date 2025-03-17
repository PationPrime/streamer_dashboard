import 'dart:async';

import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';
import 'package:window_manager/window_manager.dart';

part 'app_window_buttons.dart';

class AppWindowTitleBar extends StatefulWidget {
  const AppWindowTitleBar({super.key});

  @override
  State<AppWindowTitleBar> createState() => _AppWindowTitleBarState();
}

class _AppWindowTitleBarState extends State<AppWindowTitleBar> {
  double dragStartX = 0;
  double dragStartY = 0;

  Future<void> _updateWindowPosition(Offset offsetPosition) async {
    final initialWindowPosition = await windowManager.getPosition();

    await windowManager.setPosition(
      Offset(
        initialWindowPosition.dx + offsetPosition.dx,
        initialWindowPosition.dy + offsetPosition.dy,
      ),
    );
  }

  void _maximizeMinimizeWindow() async {
    final isMaximized = await windowManager.isMaximized();

    if (isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanStart: (detail) async {
          dragStartX = detail.globalPosition.dx;
          dragStartY = detail.globalPosition.dy;
        },
        onPanUpdate: (detail) async {
          final isMaximized = await windowManager.isMaximized();

          if (isMaximized) {
            await windowManager.unmaximize();
          }

          await _updateWindowPosition(
            Offset(
              detail.globalPosition.dx - dragStartX,
              detail.globalPosition.dy - dragStartY,
            ),
          );
        },
        onDoubleTap: _maximizeMinimizeWindow,
        onPanEnd: (detail) {},
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: context.color.background,
            border: Border(
              bottom: BorderSide(
                color: context.color.lightBorder,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Assets.appLogo.appLogoPng.image(
                height: 40,
                width: 40,
              ),
              const Spacer(),
              const _AppWindowButtons(),
            ],
          ),
        ),
      );
}
