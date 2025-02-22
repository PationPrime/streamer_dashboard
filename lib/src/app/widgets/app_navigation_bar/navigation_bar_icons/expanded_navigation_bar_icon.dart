import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import 'navigation_bar_icon.dart';

class ExpandedNavigationBarIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets margin;
  final String? label;
  final Color? labelColor;

  const ExpandedNavigationBarIcon({
    super.key,
    required this.icon,
    this.size = 70,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
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
        width: null,
        height: 40,
        margin: margin,
        mainAxisAlignment: MainAxisAlignment.start,
        iconPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        borderRadius: borderRadius,
        backgroundColor: backgroundColor ?? context.color.secondary,
        contentAlignment: Alignment.centerLeft,
        label: label,
        labelColor: labelColor,
      );
}
