import 'package:flutter/material.dart';

class NavigatorKeyProvider {
  static final GlobalKey<NavigatorState> _instance =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get instance => _instance;

  NavigatorKeyProvider._();
}
