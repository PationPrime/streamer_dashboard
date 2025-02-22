import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import 'navigation_bar_icons.dart';

class CollapsedNavigationBarIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets margin;
  final String? label;
  final Color? labelColor;

  const CollapsedNavigationBarIcon({
    super.key,
    required this.icon,
    this.size = 50,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(15),
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
    this.backgroundColor,
    this.iconColor,
    this.margin = EdgeInsets.zero,
    this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) => NavigationBarIcon(
        icon: icon,
        width: size,
        height: size,
        margin: margin,
        mainAxisAlignment: MainAxisAlignment.center,
        iconPadding: EdgeInsets.zero,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor ?? context.color.secondary,
        contentAlignment: Alignment.center,
        label: label,
        labelColor: labelColor,
      );
}
