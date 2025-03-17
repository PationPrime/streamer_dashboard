import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';

import '../../../assets_gen/assets.gen.dart';
import 'app_navigation_bar.dart';
import 'app_navigation_bar_item.dart';
import 'navigation_bar_icons/finalize_icon.dart';

class AppDefaultNavigationBar extends StatelessWidget {
  final bool horizontal;
  final void Function(int)? onActiveIndexChanged;

  const AppDefaultNavigationBar({
    super.key,
    this.horizontal = false,
    this.onActiveIndexChanged,
  });

  @override
  Widget build(BuildContext context) => AppNavigationBar(
        boxShadow: horizontal ? null : [],
        portraitMargin: EdgeInsets.only(),
        landscapeMargin: EdgeInsets.only(),
        landscapeBorderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
        contentPadding: horizontal
            ? const EdgeInsets.symmetric(
                horizontal: 20,
              )
            : const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
        border: horizontal
            ? null
            : Border(
                right: BorderSide(
                  width: 0.5,
                  color: context.color.lightBorder,
                ),
              ),
        onActiveIndexChanged: onActiveIndexChanged,
        items: [
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.closeCross.path,
              label: LocaleKeys.navigation_bar_dashboard.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.closeCross.path,
              label: LocaleKeys.navigation_bar_dashboard.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_donations.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_donations.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_streams.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_streams.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_authentication.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_authentication.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_accounts.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_accounts.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_chatbot.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_chatbot.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_stream_widgets.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_stream_widgets.tr(),
              labelColor: context.color.primary,
            ),
          ),
          AppNavigationBarItem(
            activeIcon: FinalizeIcon(
              expanded: !horizontal,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_settings.tr(),
            ),
            inActiveIcon: FinalizeIcon(
              expanded: !horizontal,
              isActive: false,
              color: context.color.primary,
              assetPath: Assets.icons.iconRefresh.path,
              label: LocaleKeys.navigation_bar_settings.tr(),
              labelColor: context.color.primary,
            ),
          )
        ],
      );
}
