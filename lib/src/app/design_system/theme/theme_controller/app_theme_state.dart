part of 'app_theme_controller.dart';

class AppThemeState extends Equatable {
  final AppThemeType themeType;

  const AppThemeState({
    required this.themeType,
  });

  @override
  List<Object?> get props => [
        themeType,
      ];

  AppThemeState copyWith({
    AppThemeType? themeType,
  }) =>
      AppThemeState(
        themeType: themeType ?? this.themeType,
      );
}

final class AppThemeInitialState extends AppThemeState {
  const AppThemeInitialState({
    required super.themeType,
  });
}
