import 'dart:io';

import 'package:flutter/foundation.dart';

import 'desktop_runapp.dart';
import 'web_runapp.dart';

abstract final class AppModule {
  static void init() {
    if (kIsWeb) {
      WebRunapp.webRunApp();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      DesktopRunApp.desktopRunApp();
    }
  }
}
