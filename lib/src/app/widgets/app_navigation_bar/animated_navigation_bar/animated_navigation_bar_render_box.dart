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

  late AnimatedNavigationBarSelectionStyle _selectionStyle;
  AnimatedNavigationBarSelectionStyle get selectionStyle => _selectionStyle;

  set selectionStyle(AnimatedNavigationBarSelectionStyle value) {
    if (_selectionStyle == value) return;
    _selectionStyle = value;
    markNeedsPaint();
  }

  late Axis _barAxis;
  Axis get barAxis => _barAxis;

  set barAxis(Axis value) {
    if (value == _barAxis) return;
    _barAxis = value;
  }

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
    required int selectedIndex,
    this.onItemSelected,
    required Animation<double> highlightAnimation,
    required Axis barAxis,
    required AnimatedNavigationBarSelectionStyle selectionStyle,
  })  : _selectedIndex = selectedIndex,
        _highlightAnimation = highlightAnimation,
        _barAxis = barAxis,
        _selectionStyle = selectionStyle {
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
    double totalHeight = 0;
    double totalWidth = 0;

    RenderBox? child = firstChild;
    double dx = 0;
    double dy = 0;

    while (child != null) {
      child.layout(
        BoxConstraints.tightFor(
          width: barAxis == Axis.horizontal ? null : constraints.maxWidth,
        ),
        parentUsesSize: true,
      );

      final childParentData =
          child.parentData as AnimatedNavigationBarParentData;

      childParentData.offset = Offset(dx, dy);

      if (barAxis == Axis.horizontal) {
        dx += child.size.width;
        totalWidth += child.size.width;
      } else {
        dy += child.size.height;
        totalHeight += child.size.height;
      }

      child = childAfter(child);
    }

    size = barAxis == Axis.horizontal
        ? Size(
            totalWidth,
            constraints.maxHeight,
          )
        : Size(
            constraints.maxWidth,
            totalHeight,
          );
  }

  Rect? _selectedRect;
  double dxPosition = 0;
  double dyPosition = 0;
  double _highlightWidth = 0;
  double _highlighHeight = 0;

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

  Paint get highlightPaint => Paint()..color = selectionStyle.color;

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? selectedChild = _getChildAtIndex(_selectedIndex);
    if (selectedChild == null) return;
    double dxDifference = 0.0;
    double dyDifference = 0.0;

    final selectedRectDx = _selectedRect?.bottomLeft.dx ?? 0;
    final selectedRectDy = _selectedRect?.topLeft.dy ?? 0;

    final selectedWidth = selectedChild.size.width;
    final selectedHeight = selectedChild.size.height;

    if (barAxis == Axis.horizontal) {
      dxDifference = selectedRectDx - dxPosition;
      dxPosition += dxDifference * _highlightAnimation.value;
    } else {
      dyDifference = selectedRectDy - dyPosition;
      dyPosition += dyDifference * _highlightAnimation.value;
    }

    double widthDifference = selectedWidth - _highlightWidth;
    _highlightWidth += widthDifference * _highlightAnimation.value;

    double heightDifference = selectedHeight - _highlighHeight;
    _highlighHeight += heightDifference * _highlightAnimation.value;

    context.canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          dxPosition,
          offset.dy + dyPosition,
          _highlightWidth,
          _highlighHeight,
        ),
        topLeft: selectionStyle.borderRadius.topLeft,
        topRight: selectionStyle.borderRadius.topRight,
        bottomLeft: selectionStyle.borderRadius.bottomLeft,
        bottomRight: selectionStyle.borderRadius.bottomRight,
      ),
      highlightPaint,
    );

    if (_highlightAnimation.value == 1) {
      dxDifference = 0.0;
      dyDifference = 0.0;
      widthDifference = 0.0;
    }

    defaultPaint(context, offset);
  }

  bool _findPointer(
    Offset localPosition, {
    bool select = true,
  }) {
    RenderBox? child = firstChild;
    int index = 0;

    while (child != null) {
      final childParentData =
          child.parentData as AnimatedNavigationBarParentData;

      final childRect = Rect.fromLTWH(
        childParentData.offset.dx,
        childParentData.offset.dy,
        child.size.width,
        child.size.height,
      );

      if (childRect.contains(localPosition)) {
        if (select) {
          _selectedRect = childRect;
          onItemSelected?.call(index);
        }

        return true;
      }

      child = childAfter(child);
      index++;
    }

    return false;
  }

  void _changePointerStyle(bool contains) {
    if (contains) {
      SystemChannels.mouseCursor.invokeMethod<void>(
        'activateSystemCursor',
        {'kind': 'click'}, // Используем курсор для клика
      );
    } else {
      SystemChannels.mouseCursor.invokeMethod<void>(
        'activateSystemCursor',
        {'kind': 'basic'}, // Стандартный курсор
      );
    }
  }

  @override
  void handleEvent(
    PointerEvent event,
    covariant HitTestEntry<HitTestTarget> entry,
  ) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      _findPointer(event.localPosition);
    } else if (event is PointerHoverEvent) {
      final contains = _findPointer(
        event.localPosition,
        select: false,
      );

      _changePointerStyle(contains);
    }
  }

  @override
  bool hitTestChildren(
    BoxHitTestResult result, {
    required Offset position,
  }) =>
      true;
}
