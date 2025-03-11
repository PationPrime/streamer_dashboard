import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:live_stream_widgets/src/app/extensions/math_extensions.dart';
import 'package:live_stream_widgets/src/app/extensions/offset_extensions.dart';

part 'ball.dart';
part 'ball_physics.dart';
part 'falling_balls_render_box.dart';
part 'falling_balls_render_object_widget.dart';

class FallingBalls extends StatefulWidget {
  final double minBallRadius;
  final double maxBallRadius;
  final Duration controllerUpdateDuration;
  final bool showCollisionShape;
  final double bottomMargin;

  const FallingBalls({
    super.key,
    this.minBallRadius = 15,
    this.maxBallRadius = 20,
    this.controllerUpdateDuration = const Duration(
      milliseconds: 16,
    ), // equals to 60 FPS
    this.showCollisionShape = false,
    this.bottomMargin = 100,
  }) : assert(
          minBallRadius <= maxBallRadius,
        );

  @override
  State<FallingBalls> createState() => _FallingBallsState();
}

class _FallingBallsState extends State<FallingBalls>
    with SingleTickerProviderStateMixin, BallPhysics {
  late AnimationController _controller;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.controllerUpdateDuration,
    );
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _FallingBallsLeafRenderObjectWidget(
        controller: _controller,
        minBallRadius: widget.minBallRadius,
        maxBallRadius: widget.maxBallRadius,
        showCollisionShape: widget.showCollisionShape,
        bottomMargin: widget.bottomMargin,
      );
}
