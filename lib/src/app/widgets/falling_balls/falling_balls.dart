import 'dart:math';

import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

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
    final ball = Ball(
      position: _basePosition(
        maxWidth: 300,
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
      if (ball.position.dy + ball.radius > 400) {
        ball.position = _updatePosition(
          position: ball.position,
          maxHeight: 400,
          radius: ball.radius,
        );

        ball.velocity = _updateVelocity(
          dx: ball.velocity.dx,
          dy: ball.velocity.dy,
        );
      }

      /// Check collision
      for (final otherBall in balls) {
        if (ball != otherBall && _checkCollision(ball, otherBall)) {
          _resolveCollision(ball, otherBall);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size(
          widget.widht,
          widget.height,
        ),
        painter: BallPainter(
          balls: balls,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
