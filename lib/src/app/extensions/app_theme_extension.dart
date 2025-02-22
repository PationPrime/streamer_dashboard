import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

extension AppThemeExtension on BuildContext {
  AppThemeTextStyles get text =>
      Theme.of(this).extension<AppThemeTextStyles>()!;

  AppThemeColors get color => Theme.of(this).extension<AppThemeColors>()!;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
