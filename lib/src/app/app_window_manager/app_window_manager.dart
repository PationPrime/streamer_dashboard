// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

const double COEF = 4.0;
final GlobalKey WINDOW_KEY = GlobalKey();
const SHOW_RESIZE_HANDLES = false;

class WindowRect extends Rect {
  WindowRect.fromLTWH(
    super.left,
    super.top,
    super.width,
    super.height,
  ) : super.fromLTWH();

  List<RectSide> toRectSides() {
    final sides = List<RectSide>.empty(
      growable: true,
    );

    sides.clear();

    // создать грани
    const n = [
      0.0,
      0.5,
      1.0,
    ];

    for (final r in n) {
      for (final i in n) {
        sides.add(
          RectSide(
            x: i * width,
            y: r * height,
            fx: i,
            fy: r,
          ),
        );
      }
    }

    return sides;
  }
}

@immutable
class RectSide {
  final double x;
  final double y;
  final double fx;
  final double fy;

  const RectSide({
    required this.x,
    required this.y,
    required this.fx,
    required this.fy,
  });
}

class _ResizeHandler extends StatefulWidget {
  final RectSide side;
  final int index;
  final List<RectSide> sides;

  const _ResizeHandler({
    required this.side,
    required this.index,
    required this.sides,
  });

  @override
  State<_ResizeHandler> createState() => _ResizeHandlerState();
}

class _ResizeHandlerState extends State<_ResizeHandler> {
  Size _initialWindowSize = Size.zero;

  // расстояние между двумя векторами
  double _distance(Point v1, Point v2) {
    var dx = (v1.x - v2.x).abs();
    var dy = (v1.y - v2.y).abs();
    return sqrt(dx * dx + dy * dy);
  }

  // получить курсор
  SystemMouseCursor _resizingCursor({
    required double fx,
    required double fy,
    required List<RectSide> sides,
  }) {
    final side = sides.indexWhere(
      (element) => element.fx == fx && element.fy == fy,
    );

    if (side == 0) {
      return SystemMouseCursors.resizeUpLeft;
    } else if (side == 1) {
      return SystemMouseCursors.resizeUp;
    } else if (side == 2) {
      return SystemMouseCursors.resizeUpRight;
    } else if (side == 3) {
      return SystemMouseCursors.resizeLeft;
    } else if (side == 5) {
      return SystemMouseCursors.resizeRight;
    } else if (side == 6) {
      return SystemMouseCursors.resizeDownLeft;
    } else if (side == 7) {
      return SystemMouseCursors.resizeDown;
    } else if (side == 8) {
      return SystemMouseCursors.resizeDownRight;
    }

    return SystemMouseCursors.click;
  }

  //
  ResizeEdge _getResizeEdge({
    required double fx,
    required double fy,
    required List<RectSide> sides,
  }) {
    final side = sides.indexWhere(
      (element) => element.fx == fx && element.fy == fy,
    );

    switch (side) {
      case 0:
        return ResizeEdge.topLeft;
      case 1:
        return ResizeEdge.top;
      case 2:
        return ResizeEdge.topRight;
      case 3:
        return ResizeEdge.left;
      case 5:
        return ResizeEdge.right;
      case 6:
        return ResizeEdge.bottomLeft;
      case 7:
        return ResizeEdge.bottom;
      case 8:
        return ResizeEdge.bottomRight;
      default:
        return ResizeEdge.right;
    }
  }

  // изменить размер окна
  Future<void> _updateWindowSize(
    Offset offsetPosition,
    Offset globalPosition,
    Size initialWindowSize,
  ) async =>
      await windowManager.startResizing(
        _getResizeEdge(
          fx: widget.side.fx,
          fy: widget.side.fy,
          sides: widget.sides,
        ),
      );

  @override
  Widget build(BuildContext context) {
    double width = COEF * 2;
    double height = COEF * 2;
    double x = widget.side.fx == 1 ? widget.side.x - COEF * 2 : widget.side.x;
    double y = widget.side.fy == 1 ? widget.side.y - COEF * 2 : widget.side.y;
    Color handleColor = Colors.red;

    if (widget.side.fx == 0.5 || widget.side.fy == 0.5) {
      if (widget.side.fx == 0.5) {
        handleColor = Colors.blue;

        final m = widget.sides[widget.index - 1];
        final u = widget.sides[widget.index + 1];

        width = _distance(Point(m.x, m.y), Point(u.x, u.y)) - COEF * 4;
        x = COEF * 2;
      }

      if (widget.side.fy == 0.5) {
        handleColor = Colors.amber;
        final m = widget.sides[widget.index - 3];
        final u = widget.sides[widget.index + 3];

        height = _distance(Point(m.x, m.y), Point(u.x, u.y)) - COEF * 4;
        y = COEF * 2;
      }
    }

    return Positioned(
      left: x,
      top: y,
      child: MouseRegion(
        cursor: _resizingCursor(
            fx: widget.side.fx, fy: widget.side.fy, sides: widget.sides),
        child: Visibility(
          visible: SHOW_RESIZE_HANDLES,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          maintainInteractivity:
              true, // Оставляем возможность взаимодействовать с объектом
          child: GestureDetector(
            onPanStart: (details) {
              if (WINDOW_KEY.currentContext != null) {
                final RenderBox renderBox =
                    WINDOW_KEY.currentContext!.findRenderObject() as RenderBox;
                _initialWindowSize = renderBox.size;
              }
            },
            onPanUpdate: (detail) async {
              if (_initialWindowSize != Size.zero) {
                await _updateWindowSize(
                  detail.delta,
                  Offset(
                    (detail.localPosition.dx),
                    (detail.localPosition.dy),
                  ),
                  _initialWindowSize,
                );
              }
            },
            child: Container(
              width: width,
              height: height,
              color: handleColor,
            ),
          ),
        ),
      ),
    );
  }
}

class AppWindowManager extends StatefulWidget {
  final Widget child;

  const AppWindowManager({
    super.key,
    required this.child,
  });

  @override
  State<AppWindowManager> createState() => _AppWindowManagerState();
}

class _AppWindowManagerState extends State<AppWindowManager> {
  Size _windowSize = Size.zero;
  final _sides = List<RectSide>.empty(growable: true);
  @override
  void initState() {
    super.initState();
    windowManager.setSize(
      const Size(
        1200,
        800,
      ),
    );
    windowManager.setMinimumSize(
      const Size(
        900,
        800,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _update(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _update() async {
    _windowSize = await windowManager.getSize();

    // getSize - получает неверный размер
    // берем из контекста flutter
    if (WINDOW_KEY.currentContext != null) {
      final RenderBox renderBox =
          WINDOW_KEY.currentContext!.findRenderObject() as RenderBox;
      _windowSize = renderBox.size;
    }

    // создать грани
    const n = [
      0.0,
      0.5,
      1.0,
    ];

    _sides.clear();

    for (final r in n) {
      for (final i in n) {
        _sides.add(
          RectSide(
            x: i * _windowSize.width,
            y: r * _windowSize.height,
            fx: i,
            fy: r,
          ),
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final resizeHandles = List<Widget>.empty(
      growable: true,
    );

    int index = 0;
    for (final side in _sides) {
      if (side.fx != 0.5 || side.fy != 0.5) {
        resizeHandles.add(
          _ResizeHandler(
            side: side,
            index: index,
            sides: _sides,
          ),
        );
      }
      index++;
    }

    return SizedBox.expand(
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          _update();
          return true;
        },
        child: SizeChangedLayoutNotifier(
          child: Stack(
            key: WINDOW_KEY,
            children: [
              widget.child,
              ...resizeHandles,
            ],
          ),
        ),
      ),
    );
  }
}
