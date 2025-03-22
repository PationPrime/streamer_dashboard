import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../animated_navigation_bar.dart';

part 'custom_animated_sliver_list.dart';

class CustomSliverList extends SliverMultiBoxAdaptorWidget {
  final int selectedIndex;
  final Animation<double> highlightAnimation;
  final AnimatedNavigationBarSelectionStyle selectionStyle;
  final double separatorHeight;

  const CustomSliverList({
    super.key,
    required super.delegate,
    required this.highlightAnimation,
    required this.selectedIndex,
    required this.selectionStyle,
    this.separatorHeight = 10,
  });

  @override
  RenderSliverMultiBoxAdaptor createRenderObject(
    BuildContext context,
  ) =>
      RenderCustomSliverList(
        childManager: context as SliverMultiBoxAdaptorElement,
        selectedIndex: selectedIndex,
        highlightAnimation: highlightAnimation,
        selectionStyle: selectionStyle,
        separatorHeight: separatorHeight,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCustomSliverList renderObject,
  ) =>
      renderObject
        ..selectedIndex = selectedIndex
        ..highlightAnimation = highlightAnimation
        ..selectionStyle = selectionStyle
        ..separatorHeight = separatorHeight;
}
