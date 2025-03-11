import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

import '../../assets_gen/assets.gen.dart';
import '../widgets/app_navigation_bar/app_navigation_bar_item.dart';
import '../widgets/app_navigation_bar/navigation_bar_icons/finalize_icon.dart';
import 'navigation_path.dart';

class RootWrapperRoute extends StatefulWidget {
  final Widget child;

  const RootWrapperRoute({
    super.key,
    required this.child,
  });

  @override
  State<RootWrapperRoute> createState() => _RootWrapperRouteState();
}

class _RootWrapperRouteState extends State<RootWrapperRoute> {
  void _navigateToPage(int activePageIndex) {
    switch (activePageIndex) {
      case 0:
        context.pushNamed(NavigationPath.root);
      case 1:
        context.pushNamed(NavigationPath.donations);
      case 2:
        context.pushNamed(NavigationPath.liveStreams);
      case 3:
        context.pushNamed(NavigationPath.authentication);
      case 4:
        context.pushNamed(NavigationPath.profiles);
      case 5:
      case 6:
        context.pushNamed(NavigationPath.streamWidgets);
      case 7:
        context.pushNamed(NavigationPath.settings);

      default:
        context.pushNamed(NavigationPath.root);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = false;
    // MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Column(
        children: [
          const AppWindowTitleBar(),

          ///
          Expanded(
            child: Row(
              children: [
                AppNavigationBar(
                  boxShadow: isPortrait ? null : [],
                  portraitMargin: EdgeInsets.only(),
                  landscapeMargin: EdgeInsets.only(),
                  landscapeBorderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  contentPadding: isPortrait
                      ? const EdgeInsets.symmetric(
                          horizontal: 20,
                        )
                      : const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                  border: isPortrait
                      ? null
                      : Border(
                          right: BorderSide(
                            width: 0.5,
                            color: context.color.lightBorder,
                          ),
                        ),
                  onActiveIndexChanged: _navigateToPage,
                  items: [
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Dashboard',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Dashboard',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Donations',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Donations',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Streams',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Streams',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Authentication',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Authentication',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Profiles',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Profiles',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Chatbot',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Chatbot',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Stream Widgets',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Stream Widgets',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                    AppNavigationBarItem(
                      activeIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        color: context.color.primary,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Settings',
                      ),
                      inActiveIcon: FinalizeIcon(
                        expanded: !isPortrait,
                        isActive: false,
                        color: context.color.mainWhite,
                        assetPath: Assets.appLogo.appLogoPng.path,
                        label: 'Settings',
                        labelColor: context.color.mainWhite,
                      ),
                    ),
                  ],
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
