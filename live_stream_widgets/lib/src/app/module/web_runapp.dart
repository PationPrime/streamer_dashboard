import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../app.dart';

abstract final class WebRunapp {
  static webRunApp() => runZonedGuarded(
        () {
          setUrlStrategy(PathUrlStrategy());
          runApp(const StreamWidgetsApp());
        },
        (error, trace) {
          debugPrint(
            'App Error: $error\nstackTrace:$trace',
          );
        },
      );
}
