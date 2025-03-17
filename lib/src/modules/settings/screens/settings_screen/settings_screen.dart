import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/design_system/design_system.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppThemeController, AppThemeState>(
        builder: (context, appThemeState) => Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            children: [
              SwitchRow(
                value: appThemeState.themeType.isDark,
                title: LocaleKeys.settings_theme_title.tr(),
                switchTitle: appThemeState.themeType.isDark
                    ? LocaleKeys.settings_theme_dark.tr()
                    : LocaleKeys.settings_theme_light.tr(),
                onChanged: (_) =>
                    context.read<AppThemeController>().toggleDarkOrLightTheme(),
              )
            ],
          ),
        ),
      );
}
