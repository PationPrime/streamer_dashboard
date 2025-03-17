import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/storage/storage.dart';
import 'package:streamer_dashboard/src/app/tools/app_logger.dart';

import '../../theme/app_theme.dart';

part 'app_theme_state.dart';
part 'app_theme_constants.dart';

class AppThemeController extends Cubit<AppThemeState> {
  late final _appLogger = AppLogger(where: '$this');

  final LocalStorageInterface _localStorage;

  AppThemeController(
    this._localStorage, {
    AppThemeType? appThemeType,
  }) : super(
          AppThemeInitialState(
            themeType:
                appThemeType ?? AppThemeControllerConstants._lightThemeType,
          ),
        );

  Future<void> _setThemeType() async {
    try {
      await _localStorage.setThemeType('${state.themeType.runtimeType}');
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to set theme type: $error',
        stackTrace: stackTrace,
        lexicalScope: 'setThemeType method',
      );
    }
  }

  Future<void> toggleDarkOrLightTheme() async {
    emit(
      state.copyWith(
        themeType: state.themeType.isDark
            ? AppThemeControllerConstants._lightThemeType
            : AppThemeControllerConstants._darkThemeType,
      ),
    );

    await _setThemeType();
  }
}
