import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/app_theme.dart';

part 'app_theme_state.dart';
part 'app_theme_constants.dart';

class AppThemeController extends Cubit<AppThemeState> {
  AppThemeController()
      : super(
          const AppThemeInitialState(
            themeType: AppThemeControllerConstants._unknownThemeType,
          ),
        ) {
    _init();
  }

  void _init() {
    toggleDarkOrLightTheme();
  }

  void toggleDarkOrLightTheme() => emit(
        state.copyWith(
          themeType: state.themeType.isDark
              ? AppThemeControllerConstants._lightThemeType
              : AppThemeControllerConstants._darkThemeType,
        ),
      );
}
