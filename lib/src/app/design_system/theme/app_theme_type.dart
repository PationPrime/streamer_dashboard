part of 'app_theme_config.dart';

sealed class AppThemeType {
  const AppThemeType._();
}

class AppDarkTheme extends AppThemeType {
  const AppDarkTheme() : super._();
}

class AppLightTheme extends AppThemeType {
  const AppLightTheme() : super._();
}

class AppOSTheme extends AppThemeType {
  const AppOSTheme() : super._();
}

class UnknownTheme extends AppThemeType {
  const UnknownTheme() : super._();
}

extension AppThemeTypeState on AppThemeType {
  bool get isDark => this is AppDarkTheme;
  bool get isLight => this is AppLightTheme;
  bool get isOSTheme => this is AppOSTheme;
  bool get isUnknownTheme => this is UnknownTheme;
}
