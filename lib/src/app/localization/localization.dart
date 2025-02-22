// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization extends StatefulWidget {
  static const Locale _EN = Locale('en', 'US');
  static const Locale _RU = Locale('ru', 'RU');

  static const List<Locale> _fallbackSupportedLocales = [
    _EN,
    _RU,
  ];
  static const Locale defaultFallbackLocale = _EN;

  final WidgetBuilder builder;
  final List<Locale>? supportedLocales;

  const AppLocalization({
    super.key,
    required this.builder,
    this.supportedLocales,
  });

  @override
  State<AppLocalization> createState() => _AppLocalizationState();
}

class _AppLocalizationState extends State<AppLocalization> {
  List<Locale> get supportedLocales =>
      widget.supportedLocales ?? AppLocalization._fallbackSupportedLocales;

  @override
  Widget build(BuildContext context) {
    var fallbackLocale = AppLocalization._EN;
    final defaultLang =
        kIsWeb ? fallbackLocale.toString() : Platform.localeName;
    for (final locale in supportedLocales) {
      if (defaultLang.contains(locale.languageCode)) {
        fallbackLocale = locale;
        break;
      }
    }

    return EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/lang/',
      fallbackLocale: fallbackLocale,
      // assetLoader: const CodegenLoader(),
      saveLocale: true,
      child: Builder(builder: widget.builder),
    );
  }
}
