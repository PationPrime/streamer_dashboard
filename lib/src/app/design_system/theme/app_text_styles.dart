import 'package:flutter/material.dart';

abstract base class AppTextStyles {
  static const _montserratFontFamily = "Montserrat";

  static const montserratExtraBold = TextStyle(
    fontSize: 18,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w800,
  );

  static const montserratExtraBoldBlack = TextStyle(
    fontSize: 18,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const montserratBold = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w700,
  );

  static const montserratBoldBlack = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const montserratSemiBold = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w600,
  );

  static const montserratSemiBoldBlack = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const montserratMedium = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w500,
  );

  static const montserratMediumBlack = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const montserratRegular = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w400,
  );

  static const montserratRegularBlack = TextStyle(
    fontSize: 20,
    fontFamily: _montserratFontFamily,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
