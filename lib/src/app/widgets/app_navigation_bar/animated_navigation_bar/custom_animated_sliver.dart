import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverList extends SliverMultiBoxAdaptorWidget {
  final int? selectedIndex;
  final Animation<double> highlightAnimation;

  const CustomSliverList({
    super.key,
    required super.delegate,
    required this.highlightAnimation,
    this.selectedIndex,
  });

  @override
  RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context) {
    return RenderCustomSliverList(
      childManager: context as SliverMultiBoxAdaptorElement,
      selectedIndex: selectedIndex,
      highlightAnimation: highlightAnimation,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCustomSliverList renderObject,
  ) =>
      renderObject
        ..selectedIndex = selectedIndex
        ..highlightAnimation = highlightAnimation;
}

class RenderCustomSliverList extends RenderSliverMultiBoxAdaptor {
  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;
  set selectedIndex(int? value) {
    if (value != _selectedIndex) {
      _selectedIndex = value;
      markNeedsPaint();
    }
  }

  late Animation<double> _highlightAnimation;
  Animation<double> get highlightAnimation => _highlightAnimation;
  set highlightAnimation(Animation<double> value) {
    if (_highlightAnimation == value) return;
    _highlightAnimation = value;
    markNeedsPaint();
  }

  void _animationChangingListener() {
    markNeedsPaint();
  }

  void _addListener() => _highlightAnimation.addListener(
        _animationChangingListener,
      );

  void _removeListener() {
    _highlightAnimation.removeListener(
      _animationChangingListener,
    );
  }

  RenderCustomSliverList({
    int? selectedIndex,
    required super.childManager,
    required Animation<double> highlightAnimation,
  })  : _selectedIndex = selectedIndex,
        _highlightAnimation = highlightAnimation {
    _addListener();
  }

  @override
  void detach() {
    if (attached) {
      _removeListener();
    }

    super.detach();
  }

  @override
  void performLayout() {
    childManager.didStartLayout();
    childManager.setDidUnderflow(false);

    collectGarbage(0, childCount);
    if (!addInitialChild()) {
      geometry = SliverGeometry.zero;
      childManager.didFinishLayout();
      return;
    }

    RenderBox? child = firstChild;
    int index = indexOf(child!);

    double childMainAxisPosition = 0;
    double paintExtent = 0;
    double maxScrollExtent = 0;

    while (child != null) {
      final SliverMultiBoxAdaptorParentData childParentData =
          child.parentData as SliverMultiBoxAdaptorParentData;

      child.layout(
        constraints.asBoxConstraints(),
        parentUsesSize: true,
      );

      final double childExtent = child.size.height;
      childParentData.layoutOffset = childMainAxisPosition;

      childMainAxisPosition += childExtent;
      paintExtent += childExtent;
      maxScrollExtent += childExtent;

      index++;
      child = childAfter(child) ??
          insertAndLayoutChild(
            constraints.asBoxConstraints(),
            after: lastChild,
          );
    }

    geometry = SliverGeometry(
      scrollExtent: maxScrollExtent,
      paintExtent: paintExtent.clamp(0.0, constraints.remainingPaintExtent),
      maxPaintExtent: maxScrollExtent,
      hasVisualOverflow: maxScrollExtent > constraints.remainingPaintExtent,
    );

    childManager.didFinishLayout();
  }

  Rect? _selectedRect;
  double dxPosition = 0;
  double dyPosition = 0;
  double _highlighHeight = 0;

  RenderBox? _getChildAtIndex(int index) {
    RenderBox? child = firstChild;
    int currentIndex = 0;

    while (child != null) {
      if (currentIndex == index) return child;
      child = childAfter(child);
      currentIndex++;
    }

    return null;
  }

  Paint get highlightPaint => Paint()..color = Colors.white.withAlpha(150);

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    if (selectedIndex == null || _selectedIndex == null) return;

    RenderBox? selectedChild = _getChildAtIndex(
      _selectedIndex!,
    );

    if (selectedChild == null) return;

    final parentData =
        selectedChild.parentData as SliverMultiBoxAdaptorParentData;

    final childRect = Rect.fromLTWH(
      0,
      parentData.layoutOffset ?? 0,
      selectedChild.size.width,
      selectedChild.size.height,
    );

    _selectedRect = childRect;

    final selectedHeight = selectedChild.size.height;

    double dyDifference = 0.0;

    final selectedRectDy = _selectedRect?.topLeft.dy ?? 0;

    dyDifference = selectedRectDy - dyPosition;
    dyPosition += dyDifference * _highlightAnimation.value;

    double heightDifference = selectedHeight - _highlighHeight;
    _highlighHeight += heightDifference * _highlightAnimation.value;

    RenderBox? child = firstChild;

    if (child == null) return;

    final size = child.size;

    final selectionDy = offset.dy + dyPosition - constraints.scrollOffset;

    context.canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          dxPosition,
          selectionDy,
          size.width,
          size.height,
        ),
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      highlightPaint,
    );

    if (_highlightAnimation.value == 1) {
      dyDifference = 0.0;
      _selectedRect = null;
    }
  }
}
