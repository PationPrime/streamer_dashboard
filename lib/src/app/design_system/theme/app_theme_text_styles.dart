import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemeTextStyles extends ThemeExtension<AppThemeTextStyles> {
  final TextStyle hint;
  final TextStyle input;
  final TextStyle body;

  // headline regular
  final TextStyle headline1Regular;
  final TextStyle headline2Regular;
  final TextStyle headline3Regular;
  final TextStyle headline4Regular;
  final TextStyle headline5Regular;
  final TextStyle headline6Regular;

  // headline medium
  final TextStyle headline1Medium;
  final TextStyle headline2Medium;
  final TextStyle headline3Medium;
  final TextStyle headline4Medium;
  final TextStyle headline5Medium;
  final TextStyle headline6Medium;

  // headline semi-bold
  final TextStyle headline1SemiBold;
  final TextStyle headline2SemiBold;
  final TextStyle headline3SemiBold;
  final TextStyle headline4SemiBold;
  final TextStyle headline5SemiBold;
  final TextStyle headline6SemiBold;

  // headline bold
  final TextStyle headline1Bold;
  final TextStyle headline2Bold;
  final TextStyle headline3Bold;
  final TextStyle headline4Bold;
  final TextStyle headline5Bold;
  final TextStyle headline6Bold;

  // headline extra-bold
  final TextStyle headline1ExtraBold;
  final TextStyle headline2ExtraBold;
  final TextStyle headline3ExtraBold;
  final TextStyle headline4ExtraBold;
  final TextStyle headline5ExtraBold;
  final TextStyle headline6ExtraBold;

  const AppThemeTextStyles({
    required this.hint,
    required this.input,
    required this.body,
    required this.headline1Regular,
    required this.headline2Regular,
    required this.headline3Regular,
    required this.headline4Regular,
    required this.headline5Regular,
    required this.headline6Regular,
    required this.headline1Medium,
    required this.headline2Medium,
    required this.headline3Medium,
    required this.headline4Medium,
    required this.headline5Medium,
    required this.headline6Medium,
    required this.headline1SemiBold,
    required this.headline2SemiBold,
    required this.headline3SemiBold,
    required this.headline4SemiBold,
    required this.headline5SemiBold,
    required this.headline6SemiBold,
    required this.headline1Bold,
    required this.headline2Bold,
    required this.headline3Bold,
    required this.headline4Bold,
    required this.headline5Bold,
    required this.headline6Bold,
    required this.headline1ExtraBold,
    required this.headline2ExtraBold,
    required this.headline3ExtraBold,
    required this.headline4ExtraBold,
    required this.headline5ExtraBold,
    required this.headline6ExtraBold,
  });

  @override
  ThemeExtension<AppThemeTextStyles> copyWith({
    TextStyle? hint,
    TextStyle? input,
    TextStyle? body,
    TextStyle? headline1Regular,
    TextStyle? headline2Regular,
    TextStyle? headline3Regular,
    TextStyle? headline4Regular,
    TextStyle? headline5Regular,
    TextStyle? headline6Regular,
    TextStyle? headline1Medium,
    TextStyle? headline2Medium,
    TextStyle? headline3Medium,
    TextStyle? headline4Medium,
    TextStyle? headline5Medium,
    TextStyle? headline6Medium,
    TextStyle? headline1SemiBold,
    TextStyle? headline2SemiBold,
    TextStyle? headline3SemiBold,
    TextStyle? headline4SemiBold,
    TextStyle? headline5SemiBold,
    TextStyle? headline6SemiBold,
    TextStyle? headline1Bold,
    TextStyle? headline2Bold,
    TextStyle? headline3Bold,
    TextStyle? headline4Bold,
    TextStyle? headline5Bold,
    TextStyle? headline6Bold,
    TextStyle? headline1ExtraBold,
    TextStyle? headline2ExtraBold,
    TextStyle? headline3ExtraBold,
    TextStyle? headline4ExtraBold,
    TextStyle? headline5ExtraBold,
    TextStyle? headline6ExtraBold,
  }) =>
      AppThemeTextStyles(
        hint: hint ?? this.hint,
        input: input ?? this.input,
        body: body ?? this.body,
        headline1Regular: headline1Regular ?? this.headline1Regular,
        headline2Regular: headline2Regular ?? this.headline2Regular,
        headline3Regular: headline3Regular ?? this.headline3Regular,
        headline4Regular: headline4Regular ?? this.headline4Regular,
        headline5Regular: headline5Regular ?? this.headline5Regular,
        headline6Regular: headline6Regular ?? this.headline6Regular,
        headline1Medium: headline1Medium ?? this.headline1Medium,
        headline2Medium: headline2Medium ?? this.headline2Medium,
        headline3Medium: headline3Medium ?? this.headline3Medium,
        headline4Medium: headline4Medium ?? this.headline4Medium,
        headline5Medium: headline5Medium ?? this.headline5Medium,
        headline6Medium: headline6Medium ?? this.headline6Medium,
        headline1SemiBold: headline1SemiBold ?? this.headline1SemiBold,
        headline2SemiBold: headline2SemiBold ?? this.headline2SemiBold,
        headline3SemiBold: headline3SemiBold ?? this.headline3SemiBold,
        headline4SemiBold: headline4SemiBold ?? this.headline4SemiBold,
        headline5SemiBold: headline5SemiBold ?? this.headline5SemiBold,
        headline6SemiBold: headline6SemiBold ?? this.headline6SemiBold,
        headline1Bold: headline1Bold ?? this.headline1Bold,
        headline2Bold: headline2Bold ?? this.headline2Bold,
        headline3Bold: headline3Bold ?? this.headline3Bold,
        headline4Bold: headline4Bold ?? this.headline4Bold,
        headline5Bold: headline5Bold ?? this.headline5Bold,
        headline6Bold: headline6Bold ?? this.headline6Bold,
        headline1ExtraBold: headline1ExtraBold ?? this.headline1ExtraBold,
        headline2ExtraBold: headline2ExtraBold ?? this.headline2ExtraBold,
        headline3ExtraBold: headline3ExtraBold ?? this.headline3ExtraBold,
        headline4ExtraBold: headline4ExtraBold ?? this.headline4ExtraBold,
        headline5ExtraBold: headline5ExtraBold ?? this.headline5ExtraBold,
        headline6ExtraBold: headline6ExtraBold ?? this.headline6ExtraBold,
      );

  @override
  ThemeExtension<AppThemeTextStyles> lerp(
    covariant ThemeExtension<AppThemeTextStyles>? other,
    double t,
  ) {
    if (other is! AppThemeTextStyles) {
      return this;
    }

    return AppThemeTextStyles(
      hint: TextStyle.lerp(
        hint,
        other.hint,
        t,
      )!,
      input: TextStyle.lerp(
        input,
        other.input,
        t,
      )!,
      body: TextStyle.lerp(
        body,
        other.body,
        t,
      )!,
      headline1Regular: TextStyle.lerp(
        headline1Regular,
        other.headline1Regular,
        t,
      )!,
      headline2Regular: TextStyle.lerp(
        headline2Regular,
        other.headline2Regular,
        t,
      )!,
      headline3Regular: TextStyle.lerp(
        headline3Regular,
        other.headline3Regular,
        t,
      )!,
      headline4Regular: TextStyle.lerp(
        headline4Regular,
        other.headline4Regular,
        t,
      )!,
      headline5Regular: TextStyle.lerp(
        headline5Regular,
        other.headline5Regular,
        t,
      )!,
      headline6Regular: TextStyle.lerp(
        headline6Regular,
        other.headline6Regular,
        t,
      )!,
      headline1Medium: TextStyle.lerp(
        headline1Medium,
        other.headline1Medium,
        t,
      )!,
      headline2Medium: TextStyle.lerp(
        headline2Medium,
        other.headline2Medium,
        t,
      )!,
      headline3Medium: TextStyle.lerp(
        headline3Medium,
        other.headline3Medium,
        t,
      )!,
      headline4Medium: TextStyle.lerp(
        headline4Medium,
        other.headline4Medium,
        t,
      )!,
      headline5Medium: TextStyle.lerp(
        headline5Medium,
        other.headline5Medium,
        t,
      )!,
      headline6Medium: TextStyle.lerp(
        headline6Medium,
        other.headline6Medium,
        t,
      )!,
      headline1SemiBold: TextStyle.lerp(
        headline1SemiBold,
        other.headline1SemiBold,
        t,
      )!,
      headline2SemiBold: TextStyle.lerp(
        headline2SemiBold,
        other.headline2SemiBold,
        t,
      )!,
      headline3SemiBold: TextStyle.lerp(
        headline3SemiBold,
        other.headline3SemiBold,
        t,
      )!,
      headline4SemiBold: TextStyle.lerp(
        headline4SemiBold,
        other.headline4SemiBold,
        t,
      )!,
      headline5SemiBold: TextStyle.lerp(
        headline5SemiBold,
        other.headline5SemiBold,
        t,
      )!,
      headline6SemiBold: TextStyle.lerp(
        headline6SemiBold,
        other.headline6SemiBold,
        t,
      )!,
      headline1Bold: TextStyle.lerp(
        headline1Bold,
        other.headline1Bold,
        t,
      )!,
      headline2Bold: TextStyle.lerp(
        headline2Bold,
        other.headline2Bold,
        t,
      )!,
      headline3Bold: TextStyle.lerp(
        headline3Bold,
        other.headline3Bold,
        t,
      )!,
      headline4Bold: TextStyle.lerp(
        headline4Bold,
        other.headline4Bold,
        t,
      )!,
      headline5Bold: TextStyle.lerp(
        headline5Bold,
        other.headline5Bold,
        t,
      )!,
      headline6Bold: TextStyle.lerp(
        headline6Bold,
        other.headline6Bold,
        t,
      )!,
      headline1ExtraBold: TextStyle.lerp(
        headline1ExtraBold,
        other.headline1ExtraBold,
        t,
      )!,
      headline2ExtraBold: TextStyle.lerp(
        headline2ExtraBold,
        other.headline2ExtraBold,
        t,
      )!,
      headline3ExtraBold: TextStyle.lerp(
        headline3ExtraBold,
        other.headline3ExtraBold,
        t,
      )!,
      headline4ExtraBold: TextStyle.lerp(
        headline4ExtraBold,
        other.headline4ExtraBold,
        t,
      )!,
      headline5ExtraBold: TextStyle.lerp(
        headline5ExtraBold,
        other.headline5ExtraBold,
        t,
      )!,
      headline6ExtraBold: TextStyle.lerp(
        headline6ExtraBold,
        other.headline6ExtraBold,
        t,
      )!,
    );
  }

  static final lightThemeTextStyles = AppThemeTextStyles(
    ///
    hint: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.greyD6D6D6,
    ),

    ///
    input: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
    ),

    ///
    body: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 18,
    ),

    ///
    headline1Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 32,
    ),

    ///
    headline2Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 28,
    ),

    ///
    headline3Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 24,
    ),

    ///
    headline4Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 20,
    ),

    ///
    headline5Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 16,
    ),

    ///
    headline6Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 12,
    ),

    ///
    headline1Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 32,
    ),

    ///
    headline2Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 28,
    ),

    ///
    headline3Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 24,
    ),

    ///
    headline4Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 20,
    ),

    ///
    headline5Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 16,
    ),

    ///
    headline6Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 12,
    ),

    ///
    headline1SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 32,
    ),

    ///
    headline2SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 28,
    ),

    ///
    headline3SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 24,
    ),

    ///
    headline4SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 20,
    ),

    ///
    headline5SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 16,
    ),

    ///
    headline6SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 12,
    ),

    ///
    headline1Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 32,
    ),

    ///
    headline2Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 28,
    ),

    ///
    headline3Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 24,
    ),

    ///
    headline4Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 20,
    ),

    ///
    headline5Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 16,
    ),

    ///
    headline6Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 12,
    ),

    ///
    headline1ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 32,
    ),

    ///
    headline2ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 28,
    ),

    ///
    headline3ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 24,
    ),

    ///
    headline4ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 20,
    ),

    ///
    headline5ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 16,
    ),

    ///
    headline6ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.black2E2E2E,
      fontSize: 12,
    ),
  );

  static final darkThemeTextStyles = AppThemeTextStyles(
    ///
    hint: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.grey707070,
    ),

    ///
    input: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
    ),

    ///
    body: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 18,
    ),

    ///
    headline1Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 32,
    ),

    ///
    headline2Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 28,
    ),

    ///
    headline3Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 24,
    ),

    ///
    headline4Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 20,
    ),

    ///
    headline5Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 16,
    ),

    ///
    headline6Regular: AppTextStyles.montserratRegular.copyWith(
      color: AppColors.white,
      fontSize: 12,
    ),

    ///
    headline1Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 32,
    ),

    ///
    headline2Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 28,
    ),

    ///
    headline3Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 24,
    ),

    ///
    headline4Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 20,
    ),

    ///
    headline5Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 16,
    ),

    ///
    headline6Medium: AppTextStyles.montserratMedium.copyWith(
      color: AppColors.white,
      fontSize: 12,
    ),

    ///
    headline1SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 32,
    ),

    ///
    headline2SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 28,
    ),

    ///
    headline3SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 24,
    ),

    ///
    headline4SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 20,
    ),

    ///
    headline5SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 16,
    ),

    ///
    headline6SemiBold: AppTextStyles.montserratSemiBold.copyWith(
      color: AppColors.white,
      fontSize: 12,
    ),

    ///
    headline1Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 32,
    ),

    ///
    headline2Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 28,
    ),

    ///
    headline3Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 24,
    ),

    ///
    headline4Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 20,
    ),

    ///
    headline5Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 16,
    ),

    ///
    headline6Bold: AppTextStyles.montserratBold.copyWith(
      color: AppColors.white,
      fontSize: 12,
    ),

    ///
    headline1ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 32,
    ),

    ///
    headline2ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 28,
    ),

    ///
    headline3ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 24,
    ),

    ///
    headline4ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 20,
    ),

    ///
    headline5ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 16,
    ),

    ///
    headline6ExtraBold: AppTextStyles.montserratExtraBold.copyWith(
      color: AppColors.white,
      fontSize: 12,
    ),
  );
}
