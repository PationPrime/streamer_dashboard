import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:streamer_dashboard/src/app/tools/app_logger.dart';

part 'animated_navigaion_bar_parent_data.dart';
part 'animated_navigation_bar_render_box.dart';

class AnimatedNavigationBarWidget extends MultiChildRenderObjectWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Animation<double> highlightAnimation;

  const AnimatedNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required super.children,
    required this.highlightAnimation,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      AnimatedNavigationBarRenderBox(
        onItemSelected: onItemSelected,
        highlightAnimation: highlightAnimation,
      )..selectedIndex = selectedIndex;

  @override
  void updateRenderObject(
    BuildContext context,
    AnimatedNavigationBarRenderBox renderObject,
  ) =>
      renderObject
        ..selectedIndex = selectedIndex
        ..onItemSelected = onItemSelected
        ..highlightAnimation = highlightAnimation;
}
