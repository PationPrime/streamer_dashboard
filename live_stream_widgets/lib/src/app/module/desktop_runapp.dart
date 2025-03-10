import 'dart:async';

import 'package:flutter/material.dart';

import '../app.dart';

abstract final class DesktopRunApp {
  static desktopRunApp() => runZonedGuarded(
        () => runApp(
          const StreamWidgetsApp(),
        ),
        (error, trace) {
          debugPrint(
            'App Error: $error\nstackTrace:$trace',
          );
        },
      );
}
