import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color background;
  final Color navigationBar;
  final Color primary;
  final Color secondary;
  final Color active;
  final Color activeDeep;
  final Color disabled;
  final Color hint;
  final Color focus;
  final Color unfocus;
  final Color cancel;
  final Color alert;
  final Color arrowBack;
  final Color transparent;
  final Color border;
  final Color defaultInput;
  final Color inputCursor;
  final Color lightBorder;
  final Color warning;
  final Color mainWhite;
  final Color mainBlack;
  final Color mapOcean;

  const AppThemeColors({
    required this.background,
    required this.navigationBar,
    required this.primary,
    required this.secondary,
    required this.active,
    required this.activeDeep,
    required this.disabled,
    required this.hint,
    required this.focus,
    required this.unfocus,
    required this.cancel,
    required this.alert,
    required this.arrowBack,
    required this.transparent,
    required this.border,
    required this.defaultInput,
    required this.inputCursor,
    required this.lightBorder,
    required this.warning,
    required this.mainWhite,
    required this.mainBlack,
    required this.mapOcean,
  });

  @override
  AppThemeColors copyWith({
    Color? background,
    Color? navigationBar,
    Color? primary,
    Color? secondary,
    Color? active,
    Color? activeDeep,
    Color? disabled,
    Color? hint,
    Color? focus,
    Color? unfocus,
    Color? cancel,
    Color? alert,
    Color? arrowBack,
    Color? transparent,
    Color? border,
    Color? defaultInput,
    Color? inputCursor,
    Color? lightBorder,
    Color? warning,
    Color? mainWhite,
    Color? mainBlack,
    Color? mapOcean,
  }) =>
      AppThemeColors(
        background: background ?? this.background,
        navigationBar: navigationBar ?? this.navigationBar,
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        active: active ?? this.active,
        activeDeep: activeDeep ?? this.activeDeep,
        disabled: disabled ?? this.disabled,
        hint: hint ?? this.hint,
        focus: focus ?? this.focus,
        unfocus: unfocus ?? this.unfocus,
        cancel: cancel ?? this.cancel,
        alert: alert ?? this.alert,
        arrowBack: arrowBack ?? this.arrowBack,
        transparent: transparent ?? this.transparent,
        border: border ?? this.border,
        defaultInput: defaultInput ?? this.defaultInput,
        inputCursor: inputCursor ?? this.inputCursor,
        lightBorder: lightBorder ?? this.lightBorder,
        warning: warning ?? this.warning,
        mainWhite: mainWhite ?? this.mainWhite,
        mainBlack: mainBlack ?? this.mainBlack,
        mapOcean: mapOcean ?? this.mapOcean,
      );

  @override
  ThemeExtension<AppThemeColors> lerp(
    ThemeExtension<AppThemeColors>? other,
    double t,
  ) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      background: Color.lerp(
        background,
        other.background,
        t,
      )!,
      navigationBar: Color.lerp(
        navigationBar,
        other.navigationBar,
        t,
      )!,
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      )!,
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      )!,
      active: Color.lerp(
        active,
        other.active,
        t,
      )!,
      activeDeep: Color.lerp(
        activeDeep,
        other.activeDeep,
        t,
      )!,
      disabled: Color.lerp(
        disabled,
        other.disabled,
        t,
      )!,
      hint: Color.lerp(
        hint,
        other.hint,
        t,
      )!,
      focus: Color.lerp(
        focus,
        other.focus,
        t,
      )!,
      unfocus: Color.lerp(
        unfocus,
        other.unfocus,
        t,
      )!,
      cancel: Color.lerp(
        cancel,
        other.cancel,
        t,
      )!,
      alert: Color.lerp(
        alert,
        other.alert,
        t,
      )!,
      arrowBack: Color.lerp(
        arrowBack,
        other.arrowBack,
        t,
      )!,
      transparent: Color.lerp(
        transparent,
        other.transparent,
        t,
      )!,
      border: Color.lerp(
        border,
        other.border,
        t,
      )!,
      defaultInput: Color.lerp(
        defaultInput,
        other.defaultInput,
        t,
      )!,
      inputCursor: Color.lerp(
        inputCursor,
        other.inputCursor,
        t,
      )!,
      lightBorder: Color.lerp(
        lightBorder,
        other.lightBorder,
        t,
      )!,
      warning: Color.lerp(
        warning,
        other.warning,
        t,
      )!,
      mainWhite: Color.lerp(
        mainWhite,
        other.mainWhite,
        t,
      )!,
      mainBlack: Color.lerp(
        mainBlack,
        other.mainBlack,
        t,
      )!,
      mapOcean: Color.lerp(
        mapOcean,
        other.mapOcean,
        t,
      )!,
    );
  }

  static const light = AppThemeColors(
    background: AppColors.white255223225237,
    primary: AppColors.black,
    navigationBar: AppColors.white,
    secondary: AppColors.white,
    active: AppColors.mint3FB8AF,
    activeDeep: AppColors.mint268A82,
    disabled: AppColors.greyB6B6B6,
    hint: AppColors.greyD6D6D6,
    focus: AppColors.mint3FB8AF,
    unfocus: AppColors.greyD6D6D6,
    cancel: AppColors.redB24D4D,
    alert: AppColors.redD73B3B,
    arrowBack: AppColors.black,
    transparent: AppColors.transparent,
    border: AppColors.border,
    defaultInput: AppColors.white,
    inputCursor: AppColors.black,
    lightBorder: AppColors.grey555555,
    warning: AppColors.orange,
    mainWhite: AppColors.white,
    mainBlack: AppColors.black,
    mapOcean: AppColors.oceanTeal,
  );

  static const dark = AppThemeColors(
    navigationBar: AppColors.black262626,
    background: AppColors.black255525252,
    primary: AppColors.white,
    secondary: AppColors.grey3F3F3F,
    active: AppColors.mint3FB8AF,
    activeDeep: AppColors.mint268A82,
    disabled: AppColors.greyB6B6B6,
    hint: AppColors.grey707070,
    focus: AppColors.mint3FB8AF,
    unfocus: AppColors.grey707070,
    cancel: AppColors.redB24D4D,
    alert: AppColors.redD73B3B,
    arrowBack: AppColors.white,
    transparent: AppColors.transparent,
    border: AppColors.border,
    defaultInput: AppColors.black2E2E2E,
    inputCursor: AppColors.white,
    lightBorder: AppColors.grey555555,
    warning: AppColors.orange,
    mainWhite: AppColors.white,
    mainBlack: AppColors.black,
    mapOcean: AppColors.oceanTeal,
  );
}
