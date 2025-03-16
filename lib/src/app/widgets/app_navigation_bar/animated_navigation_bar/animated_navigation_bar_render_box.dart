part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AnimatedNavigationBarParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            AnimatedNavigationBarParentData> {
  late final _appLogger = AppLogger(where: '$this');

  ///
  int _selectedIndex = 0;
  Function(int)? onItemSelected;
  late Animation<double> _highlightAnimation;
  Animation<double> get highlightAnimation => _highlightAnimation;

  set highlightAnimation(Animation<double> value) {
    if (_highlightAnimation == value) return;
    _highlightAnimation = value;
    markNeedsPaint();
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

  AnimatedNavigationBarRenderBox({
    this.onItemSelected,
    required Animation<double> highlightAnimation,
  }) : _highlightAnimation = highlightAnimation {
    _addListener();
  }

  set selectedIndex(int index) {
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    markNeedsPaint();
  }

  int get selectedIndex => _selectedIndex;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! AnimatedNavigationBarParentData) {
      child.parentData = AnimatedNavigationBarParentData();
    }
  }

  @override
  void performLayout() {
    double maxWidth = constraints.maxWidth;
    double childWidth = maxWidth / childCount;
    double height = 0;

    RenderBox? child = firstChild;
    double dx = 0;

    while (child != null) {
      child.layout(
        BoxConstraints.tightFor(width: childWidth),
        parentUsesSize: true,
      );

      height = max(height, child.size.height);

      final childParentData =
          child.parentData as AnimatedNavigationBarParentData;
      childParentData.offset = Offset(dx, 0);
      dx += childWidth;

      child = childAfter(child);
    }

    size = Size(maxWidth, height);

    if (firstChild != null) {
      final selectedChild = _getChildAtIndex(_selectedIndex);

      if (selectedChild != null) {
        final childParentData =
            selectedChild.parentData as AnimatedNavigationBarParentData;
        _selectedRect = Rect.fromLTWH(
          childParentData.offset.dx,
          0,
          selectedChild.size.width,
          selectedChild.size.height,
        );
      }
    }
  }

  Rect? _selectedRect;
  double dxPosition = 0;
  double _highlightWidth = 0;

  void _animationChangingListener() {
    markNeedsPaint();
  }

  void _addListener() => highlightAnimation.addListener(
        _animationChangingListener,
      );

  void _removeListener() {
    highlightAnimation.removeListener(
      _animationChangingListener,
    );
  }

  @override
  void detach() {
    if (attached) {
      _removeListener();
    }

    super.detach();
  }

  final highlightPaint = Paint()
    ..color = Colors.redAccent.withOpacity(
      0.3,
    );

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? selectedChild = _getChildAtIndex(_selectedIndex);
    if (selectedChild == null) return;

    final selectedRectDx = _selectedRect?.bottomLeft.dx ?? 0;
    final selectedWidth = selectedChild.size.width;

    double dxDifference = selectedRectDx - dxPosition;
    dxPosition += dxDifference * _highlightAnimation.value;

    double widthDifference = selectedWidth - _highlightWidth;
    _highlightWidth += widthDifference * _highlightAnimation.value;

    context.canvas.drawRect(
      Rect.fromLTWH(
        dxPosition,
        offset.dy,
        _highlightWidth,
        selectedChild.size.height,
      ),
      highlightPaint,
    );

    if (_highlightAnimation.value == 1) {
      dxDifference = 0.0;
      widthDifference = 0.0;
    }

    defaultPaint(context, offset);
  }

  @override
  void handleEvent(
    PointerEvent event,
    covariant HitTestEntry<HitTestTarget> entry,
  ) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      RenderBox? child = firstChild;
      int index = 0;

      final tapLocalPosition = event.localPosition;

      while (child != null) {
        final childParentData =
            child.parentData as AnimatedNavigationBarParentData;

        final childRect = Rect.fromLTWH(
          childParentData.offset.dx,
          childParentData.offset.dy,
          child.size.width,
          child.size.height,
        );

        if (childRect.contains(tapLocalPosition)) {
          _selectedRect = childRect;
          onItemSelected?.call(index);
        }

        child = childAfter(child);
        index++;
      }
    }
  }

  @override
  bool hitTestChildren(
    BoxHitTestResult result, {
    required Offset position,
  }) =>
      true;
}
