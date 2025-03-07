part of 'falling_balls.dart';

class Ball {
  final double radius;
  Offset position;
  Offset velocity;

  double get mass =>
      radius.pow2().toDouble() * pi; // Приблизительная масса шара

  Ball({
    required this.position,
    required this.velocity,
    required this.radius,
  });
}
