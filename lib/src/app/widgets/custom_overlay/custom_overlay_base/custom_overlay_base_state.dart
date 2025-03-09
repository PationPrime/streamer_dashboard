part of 'custom_overlay_base.dart';

abstract class CustomOverlayBaseState<S extends CustomOverlayBase>
    extends State<S> with SingleTickerProviderStateMixin {
  final _childKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  Size? childSize;
  RenderBox? childRenderBox;

  double getXPosition({
    required CustomOverlayPosition rtOverlayPosition,
    required Offset position,
  }) {
    switch (rtOverlayPosition) {
      case CustomOverlayPosition.bottom:
        return position.dx;

      case CustomOverlayPosition.end:
        final Offset bottomRight =
            position + Offset(childSize!.width, childSize!.height);
        return bottomRight.dx;
    }
  }

  double getYPosition({
    required CustomOverlayPosition rtOverlayPosition,
    required Offset position,
  }) {
    switch (rtOverlayPosition) {
      case CustomOverlayPosition.bottom:
        final yPosition =
            position.dy + childSize!.height / 2 + widget.childTopPaddingValue;

        return yPosition;

      case CustomOverlayPosition.end:
        return position.dy;
    }
  }

  Future<void> _show({
    VoidCallback? callBack,
  }) async {
    if (widget.controller.shown) return;

    final position = childRenderBox?.localToGlobal(Offset.zero);

    if (childSize == null || position == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final entryWidget = buildEntry(context);

        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final Offset adjustedPosition = overlay.globalToLocal(position);

        return Stack(
          children: [
            Positioned(
              left: getXPosition(
                rtOverlayPosition: widget.rtOverlayPosition,
                position: adjustedPosition,
              ),
              top: getYPosition(
                rtOverlayPosition: widget.rtOverlayPosition,
                position: adjustedPosition,
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onExit: (_) => widget.controller.hide(),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: childSize!.width,
                  ),
                  color: widget.dropDownBackgroundColor,
                  child: entryWidget,
                ),
              ),
            )
          ],
        );
      },
    );

    if (_overlayEntry is OverlayEntry) {
      Overlay.of(context).insert(
        _overlayEntry!,
      );
    }
  }

  Future<void> _removeOverlayEntry({
    VoidCallback? callBack,
  }) async {
    _overlayEntry?.remove();
    _overlayEntry = null;
    callBack?.call();
  }

  @mustCallSuper
  void _setupControllers() {
    assert(
      widget.controller.state is! OverlayEntry,
      'RTOverlayBaseController attached to multiple views',
    );

    if (widget.controller.state != null || widget.controller.state == this) {
      widget.controller.clearState();
    }

    widget.controller.setupController(this);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      childRenderBox =
          _childKey.currentContext?.findRenderObject() as RenderBox?;
      childSize = childRenderBox?.size;

      setState(() {});
    });

    _setupControllers();
  }

  @override
  void didUpdateWidget(S oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.clearState();
      _setupControllers();
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  Widget buildEntry(BuildContext context);

  bool onCursorOnOverlay(PointerExitEvent event) {
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;

    final size = renderBox?.size;

    final position = renderBox?.localToGlobal(Offset.zero);

    if (size == null || position == null) return false;

    final cursorPosition = event.position;

    if (cursorPosition.dx < position.dx + size.width &&
        cursorPosition.dy > position.dy) {
      return false;
    }
    return true;
  }

  void _onPointerExit(PointerExitEvent event) {
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;

    final size = renderBox?.size;

    final position = renderBox?.localToGlobal(Offset.zero);

    if (size == null || position == null) return;

    final cursorPosition = event.position;

    switch (widget.rtOverlayPosition) {
      case CustomOverlayPosition.bottom:
        if (cursorPosition.dy < position.dy ||
            cursorPosition.dx < position.dx ||
            cursorPosition.dx > position.dx + size.width) {
          widget.controller.hide();
        }
        break;

      case CustomOverlayPosition.end:
        if (cursorPosition.dx < position.dx ||
            cursorPosition.dy < position.dy ||
            cursorPosition.dy > position.dy + size.height) {
          widget.controller.hide();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: _onPointerExit,
        onHover: widget.onHover,
        child: SizedBox(
          key: _childKey,
          child: widget.child,
        ),
      );
}
