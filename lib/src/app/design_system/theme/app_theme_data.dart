import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/design_system/design_system.dart';

abstract base class AppThemeData {
  /// Application text selection theme data
  static final textSelectionTheme = TextSelectionThemeData(
    cursorColor: AppThemeColors.light.active,
    selectionColor: AppThemeColors.light.active,
    selectionHandleColor: AppThemeColors.light.active,
  );

  /// Application ligth theme data
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppThemeColors.light.background,
    useMaterial3: true,
    textSelectionTheme: textSelectionTheme,
    dialogTheme: DialogTheme(
      backgroundColor: AppThemeColors.light.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: AppThemeTextStyles.lightThemeTextStyles.headline4Bold,
      contentTextStyle: AppThemeTextStyles.lightThemeTextStyles.headline4Medium,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppThemeColors.light.mainBlack,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppThemeTextStyles.lightThemeTextStyles.hint,
      errorStyle: AppThemeTextStyles.lightThemeTextStyles.headline6Regular,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.light.alert,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.light.active,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.light.unfocus,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.light.unfocus,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.light.disabled,
        ),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.light,
      AppThemeTextStyles.lightThemeTextStyles,
    ],
  );

  /// Application dark theme data
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppThemeColors.dark.background,
    useMaterial3: true,
    textSelectionTheme: textSelectionTheme,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppThemeColors.light.mainWhite,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppThemeColors.dark.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: AppThemeTextStyles.darkThemeTextStyles.headline4Bold,
      contentTextStyle: AppThemeTextStyles.darkThemeTextStyles.headline4Medium,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppThemeTextStyles.darkThemeTextStyles.hint,
      errorStyle: AppThemeTextStyles.darkThemeTextStyles.headline6Regular,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.dark.alert,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.dark.active,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.dark.unfocus,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.dark.unfocus,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: AppThemeColors.dark.disabled,
        ),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.dark,
      AppThemeTextStyles.darkThemeTextStyles,
    ],
  );

  /// Application fallback theme
  static final fallbackTheme = lightTheme;
}
