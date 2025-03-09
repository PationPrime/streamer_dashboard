import 'dart:math';

import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

part 'ball.dart';
part 'ball_painter.dart';
part 'ball_physics.dart';

class FallingBalls extends StatefulWidget {
  final double minBallRadius;
  final double maxBallRadius;
  final Duration controllerUpdateDuration;

  const FallingBalls({
    super.key,
    this.minBallRadius = 10,
    this.maxBallRadius = 40,
    this.controllerUpdateDuration = const Duration(
      milliseconds: 16,
    ), // equals to 60 FPS
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
  Widget build(BuildContext context) => BallLeafRenderObjectWidget(
        controller: _controller,
        minBallRadius: widget.minBallRadius,
        maxBallRadius: widget.maxBallRadius,
      );
}
