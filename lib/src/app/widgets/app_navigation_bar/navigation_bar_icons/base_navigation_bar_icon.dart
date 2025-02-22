import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'collapsed_navigation_bar_icon.dart';
import 'expanded_navigation_bar_icon.dart';

class BaseNavigationBarIcon extends StatelessWidget {
  final String? label;
  final bool expanded;
  final bool isActive;
  final Color? labelColor;
  final Widget icon;
  final EdgeInsetsGeometry margin;

  const BaseNavigationBarIcon({
    super.key,
    this.expanded = false,
    this.isActive = false,
    this.label,
    this.labelColor,
    required this.icon,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: isActive
            ? !expanded
                ? CollapsedNavigationBarIcon(
                    icon: icon,
                    label: label,
                    labelColor: labelColor ?? context.color.primary,
                  )
                : ExpandedNavigationBarIcon(
                    icon: icon,
                    label: label,
                    labelColor: labelColor ?? context.color.primary,
                  )
            : !expanded
                ? CollapsedNavigationBarIcon(
                    backgroundColor: context.color.transparent,
                    icon: icon,
                    label: label,
                    labelColor: labelColor ?? context.color.primary,
                  )
                : ExpandedNavigationBarIcon(
                    backgroundColor: context.color.transparent,
                    icon: icon,
                    label: label,
                    labelColor: labelColor ?? context.color.primary,
                  ),
      );
}
