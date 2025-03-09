part of 'falling_balls.dart';

class Ball {
  final double radius;
  Offset position;
  Offset velocity;

  /// Approximate ball mass
  double get mass => radius.pow2().toDouble() * pi;

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
  });
}
