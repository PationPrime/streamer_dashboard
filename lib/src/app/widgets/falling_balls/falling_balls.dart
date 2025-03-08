import 'dart:math';

import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/tools/app_logger.dart';

part 'ball.dart';
part 'ball_painter.dart';
part 'ball_physics.dart';

class FallingBalls extends StatefulWidget {
  final double height;
  final double widht;
  final double minBallRadius;
  final double maxBallRadius;

  const FallingBalls({
    super.key,
    this.height = 400,
    this.widht = 300,
    this.minBallRadius = 10,
    this.maxBallRadius = 20,
  }) : assert(
          minBallRadius <= maxBallRadius,
        );

  @override
  State<FallingBalls> createState() => _FallingBallsState();
}

class _FallingBallsState extends State<FallingBalls>
    with SingleTickerProviderStateMixin, BallPhysics {
  late AnimationController _controller;
  final List<Ball> balls = [];

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // 60 FPS
    )..addListener(
        () => setState(
          () => _updateBalls(),
        ),
      );

    Future.delayed(
      Duration(seconds: 1),
      _spawnBall,
    );

    _controller.repeat();
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  void _spawnBall() {
    if (balls.length > 4) balls.clear();

    final ball = Ball(
      position: _basePosition(
        maxWidth: widget.widht,
      ),
      velocity: _baseVelocity(),
      radius: _circleRadius(
        max: widget.maxBallRadius,
        min: widget.minBallRadius,
      ),
    );

    balls.add(ball);

    setState(() {});

    Future.delayed(
      Duration(seconds: 1),
      _spawnBall,
    );
  }

  void _updateBalls() {
    for (final ball in balls) {
      /// Position update depends on velocity
      ball.position += ball.velocity;

      /// Gravity
      ball.velocity = _gravity(
        velocity: ball.velocity,
      );

      /// Collision with the bottom constraint (maxHeight value)
      if (ball.position.dy + ball.radius > widget.height) {
        ball.position = _updatePosition(
          position: ball.position,
          maxHeight: widget.height,
          radius: ball.radius,
          maxWidth: widget.widht,
        );

        ball.velocity = _updateVelocity(
          dx: ball.velocity.dx,
          dy: ball.velocity.dy,
        );
      }

      /// Check collision
      for (final otherBall in balls) {
        if (ball != otherBall && _checkBallsCollision(ball, otherBall)) {
          _resolveBallsCollision(ball, otherBall);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.white,
          height: widget.height,
          width: widget.widht,
          child: ClipRect(
            child: BallLeafRenderObjectWidget(
              balls: balls,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
