part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AnimatedNavigationBarParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            AnimatedNavigationBarParentData> {
  late final _appLogger = AppLogger(where: '$this');

  late Axis _barAxis;
  Axis get barAxis => _barAxis;
  set barAxis(Axis value) {
    if (value == _barAxis) return;
    _barAxis = value;
  }

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
    required Axis barAxis,
  })  : _highlightAnimation = highlightAnimation,
        _barAxis = barAxis {
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
    double dy = 0;

    while (child != null) {
      child.layout(
        BoxConstraints.tightFor(
          width: barAxis == Axis.horizontal ? childWidth : maxWidth,
        ),
        parentUsesSize: true,
      );

      height = max(height, child.size.height);

      final childParentData =
          child.parentData as AnimatedNavigationBarParentData;
      childParentData.offset = Offset(dx, dy);

      if (barAxis == Axis.horizontal) {
        dx += childWidth;
      } else {
        dy += height;
      }

      child = childAfter(child);
    }

    size = barAxis == Axis.horizontal
        ? Size(maxWidth, height)
        : constraints.biggest;

    if (firstChild != null) {
      final selectedChild = _getChildAtIndex(_selectedIndex);

      if (selectedChild != null) {
        final childParentData =
            selectedChild.parentData as AnimatedNavigationBarParentData;
        _selectedRect = Rect.fromLTWH(
          childParentData.offset.dx,
          childParentData.offset.dy,
          barAxis == Axis.horizontal ? 0 : selectedChild.size.width,
          barAxis == Axis.horizontal ? selectedChild.size.height : 0,
        );
      }
    }
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

  final highlightPaint = Paint()
    ..color = Colors.redAccent.withOpacity(
      0.3,
    );

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

    context.canvas.drawRect(
      Rect.fromLTWH(
        dxPosition,
        offset.dy + dyPosition,
        _highlightWidth,
        _highlighHeight,
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
