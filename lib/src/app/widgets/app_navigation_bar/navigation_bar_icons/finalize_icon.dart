import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'base_navigation_bar_icon.dart';

class FinalizeIcon extends BaseNavigationBarIcon {
  FinalizeIcon({
    super.isActive = true,
    super.expanded,
    super.key,
    String? label,
    required String assetPath,
    Color? color,
    EdgeInsetsGeometry? margin,
    super.labelColor,
  }) : super(
          label: expanded ? label : null,
          icon: SvgPicture.asset(
            assetPath,
            color: color,
          ),
        );
}
