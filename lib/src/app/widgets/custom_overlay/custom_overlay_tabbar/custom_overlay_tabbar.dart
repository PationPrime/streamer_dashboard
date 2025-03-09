import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../tools/measure_widget/measure_widget.dart';
import '../custom_overlay_base/custom_overlay_base.dart';

part 'custom_overlay_tab.dart';
part 'custom_overlay_tabbar_item.dart';

class CustomOverlayTabbar extends CustomOverlayBase {
  final Function(CustomOverlayTabbarItemData data)? onTabTap;
  final List<CustomOverlayTabbarItemData> tabs;

  const CustomOverlayTabbar({
    super.key,
    required super.controller,
    required super.child,
    this.onTabTap,
    required this.tabs,
    super.onHover,
  });

  @override
  State createState() => _CustomOverlayTabbarState();
}

class _CustomOverlayTabbarState
    extends CustomOverlayBaseState<CustomOverlayTabbar> {
  List<Widget> _generateChildren() {
    Set<Widget> widgets = {};
    final Set<Size> sizes = {};

    for (final tabData in widget.tabs) {
      final entry = CustomOverlayTab(
        data: tabData,
        onTap: (data) {
          widget.controller.hide();
          widget.onTabTap?.call(data);
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
