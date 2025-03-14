import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_widgets/src/app/extensions/math_extensions.dart';
import 'package:live_stream_widgets/src/app/extensions/offset_extensions.dart';
import 'package:live_stream_widgets/src/app/models/models.dart';

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
  final List<SubsGlassBallModel> subsGlassBallModels;

  const FallingBalls({
    super.key,
    this.minBallRadius = 15,
    this.maxBallRadius = 20,
    this.controllerUpdateDuration = const Duration(
      milliseconds: 16,
    ), // equals to 60 FPS
    this.showCollisionShape = false,
    this.bottomMargin = 100,
    required this.subsGlassBallModels,
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
        subsGlassBallModels: widget.subsGlassBallModels,
      );
}
