import 'dart:async';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../app.dart';

abstract final class AppModule {
  static void init() => runZonedGuarded(
        () {
          setUrlStrategy(PathUrlStrategy());
          runApp(const StreamWidgetsApp());
        },
        (errpr, trace) {},
      );
}
