part of 'custom_animated_sliver.dart';

class RenderCustomSliverList extends RenderSliverMultiBoxAdaptor {
  Paint get highlightPaint => Paint()..color = selectionStyle.color;

  Rect? _selectedRect;
  double dxPosition = 0;
  double dyPosition = 0;
  double _highlighHeight = 0;

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

  late AnimatedNavigationBarSelectionStyle _selectionStyle;
  AnimatedNavigationBarSelectionStyle get selectionStyle => _selectionStyle;
  set selectionStyle(AnimatedNavigationBarSelectionStyle value) {
    if (_selectionStyle == value) return;
    _selectionStyle = value;
    markNeedsPaint();
  }

  late double _separatorHeight;
  double get separatorHeight => _separatorHeight;
  set separatorHeight(double value) {
    if (_separatorHeight == value) return;
    _separatorHeight = value;
    markNeedsLayout();
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
    required int selectedIndex,
    required super.childManager,
    required Animation<double> highlightAnimation,
    required AnimatedNavigationBarSelectionStyle selectionStyle,
    required double separatorHeight,
  })  : _selectedIndex = selectedIndex,
        _highlightAnimation = highlightAnimation,
        _selectionStyle = selectionStyle,
        _separatorHeight = separatorHeight {
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
    double childMainAxisPosition = 0;
    double paintExtent = 0;
    double maxScrollExtent = 0;

    while (child != null) {
      final childParentData =
          child.parentData as SliverMultiBoxAdaptorParentData;

      child.layout(
        constraints.asBoxConstraints(),
        parentUsesSize: true,
      );

      final childExtent = child.size.height + _separatorHeight;
      childParentData.layoutOffset = childMainAxisPosition;

      childMainAxisPosition += childExtent;
      paintExtent += childExtent;
      maxScrollExtent += childExtent;

      child = childAfter(child) ??
          insertAndLayoutChild(
            constraints.asBoxConstraints(),
            after: lastChild,
          );
    }

    geometry = SliverGeometry(
      scrollExtent: maxScrollExtent,
      paintExtent: paintExtent.clamp(
        0.0,
        constraints.remainingPaintExtent,
      ),
      maxPaintExtent: maxScrollExtent,
      hasVisualOverflow: maxScrollExtent > constraints.remainingPaintExtent,
    );

    childManager.didFinishLayout();
  }

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

  @override
  void paint(PaintingContext context, Offset offset) {
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

    final selectionRect = Rect.fromLTWH(
      dxPosition,
      selectionDy,
      size.width,
      size.height,
    );

    final RRect shadowRRect = RRect.fromRectAndRadius(
      selectionRect.inflate(4),
      Radius.circular(8),
    );

    final shadowPaint = Paint()
      ..color = Colors.black.withAlpha(30)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        8,
      );

    context.canvas.drawRRect(shadowRRect, shadowPaint);

    context.canvas.drawRRect(
      RRect.fromRectAndCorners(
        selectionRect,
        topLeft: selectionStyle.borderRadius.topLeft,
        topRight: selectionStyle.borderRadius.topRight,
        bottomLeft: selectionStyle.borderRadius.bottomLeft,
        bottomRight: selectionStyle.borderRadius.bottomRight,
      ),
      highlightPaint,
    );

    if (_highlightAnimation.value == 1) {
      dyDifference = 0.0;
      _selectedRect = null;
    }

    /// Draw child on top of selection
    super.paint(context, offset);
  }
}
