import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../tools/tools.dart';
import '../../widgets.dart';

part 'custom_overlay_menu_item.dart';

part 'custom_overlay_menu_item_data.dart';

class CustomOverlayMenu extends CustomOverlayBase {
  final Function(CustomOverlayMenuItemData data)? onOverlayMenuItemTap;
  final List<CustomOverlayMenuItemData> menuItems;

  const CustomOverlayMenu({
    super.key,
    required super.controller,
    required super.child,
    this.onOverlayMenuItemTap,
    required this.menuItems,
    super.onHover,
    super.rtOverlayPosition = CustomOverlayPosition.end,
  });

  @override
  State createState() => _CustomOverlayMenuState();
}

class _CustomOverlayMenuState
    extends CustomOverlayBaseState<CustomOverlayMenu> {
  List<Widget> _generateChildren() {
    Set<Widget> widgets = {};
    final Set<Size> sizes = {};

    for (final menuData in widget.menuItems) {
      final entry = CustomOverlayMenuItem(
        data: menuData,
        height: childSize?.height,
        onTap: (data) {
          widget.controller.hide();
          widget.onOverlayMenuItemTap?.call(data);
        },
      );

      final size = MeasureWidget.measureWidget(entry);

      sizes.add(size);
      widgets.add(entry);
    }

    final maxWidth = sizes.map((size) => size.width).reduce(
              math.max,
            ) +
        30;

    widgets = widgets
        .map(
          (widget) => Container(
            constraints: BoxConstraints(
              minWidth: (childSize?.width ?? 0.0) < maxWidth
                  ? maxWidth
                  : childSize!.width,
            ),
            child: widget,
          ),
        )
        .toSet();

    return widgets.toList();
  }

  @override
  Widget buildEntry(BuildContext context) => Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _generateChildren(),
        ),
      );
}
