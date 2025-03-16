import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

import 'navigation_path.dart';

class RootWrapperRoute extends StatefulWidget {
  final StatefulNavigationShell child;

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
        widget.child.goBranch(0);
      case 1:
        widget.child.goBranch(1);
      case 2:
        widget.child.goBranch(2);
      case 3:
        widget.child.goBranch(3);
      case 4:
        widget.child.goBranch(4);
      case 5:
        widget.child.goBranch(5);
      case 6:
        widget.child.goBranch(6);
      case 7:
        widget.child.goBranch(7);

      default:
        context.pushNamed(NavigationPath.root);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const AppWindowTitleBar(),
            Expanded(
              child: Row(
                children: [
                  AnimatedNavigationBar(
                    onItemSelected: _navigateToPage,
                  ),
                  Expanded(
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
