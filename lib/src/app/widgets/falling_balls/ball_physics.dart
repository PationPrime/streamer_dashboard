part of 'falling_balls.dart';

mixin BallPhysics {
  final _random = Random();

  /// Velocity
  static const _defaultVelocityMultiplier = 0.8;
  static const _bseVelocityDXMultiplier = 2.0;
  static const _bseVelocityDYMultiplier = 2.0;
  static const _bseVelocityDXRange = -1.0;
  static const _bseVelocityDYRange = 3.0;

  /// Collision
  static const _impulseCoef = 2.0;

  /// Gravity
  static const _defaultGravityValue = 0.1;

  bool _checkCollision(
    Ball ball1,
    Ball ball2,
  ) {
    final double distance = (ball1.position - ball2.position).distance;
    return distance < (ball1.radius + ball2.radius);
  }

  void _resolveCollision(
    Ball ball1,
    Ball ball2,
  ) {
    final Offset normal = (ball2.position - ball1.position) /
        (ball2.position - ball1.position).distance;

    final Offset relativeVelocity = ball2.velocity - ball1.velocity;

    final double speed = _dotProduct(relativeVelocity, normal);

    /// Do nothig if the balls have already scattered
    if (speed > 0) return;

    final impulse = _impulseCoef * speed / (ball1.mass + ball2.mass);

    ball1.velocity += normal * (impulse * ball2.mass);
    ball2.velocity -= normal * (impulse * ball1.mass);
  }

  /// Velocity
  Offset _baseVelocity({
    double dxMultiplier = _bseVelocityDXMultiplier,
    double dxRange = _bseVelocityDXRange,
    double dyMultiplier = _bseVelocityDYMultiplier,
    double dyRange = _bseVelocityDYRange,
  }) =>
      Offset(
        _random.nextDouble() * dxMultiplier + dxRange,
        _random.nextDouble() * dyMultiplier + dyRange,
      );

  Offset _updateVelocity({
    required dx,
    required dy,
    double multiplier = _defaultVelocityMultiplier,
  }) =>
      Offset(dx, -dy * multiplier);

  /// Gravity
  Offset _gravity({
    required Offset velocity,
    double value = _defaultGravityValue,
  }) =>
      Offset(
        velocity.dx,
        velocity.dy + value,
      );

  /// Circle
  double _circleRadius({
    required double max,
    required double min,
  }) {
    assert(min <= max);

    return _random.nextDouble() * max + min;
  }

  double _dotProduct(
    Offset a,
    Offset b,
  ) =>
      a.dx * b.dx + a.dy * b.dy;

  /// Position
  Offset _basePosition({
    bool randomDX = true,
    required double maxWidth,
    double dx = 0,
    double dy = 0,
  }) {
    assert(() {
      if (randomDX && dx > 0) {
        throw FlutterError(
          'If randomDX is true, then the dx value must be 0',
        );
      }

      return true;
    }());

    dx = (randomDX ? _random.nextDouble() : dx) * maxWidth;

    return Offset(dx, dy);
  }

  Offset _updatePosition({
    required Offset position,

    /// Constrained height
    required double maxHeight,
    required double radius,
  }) =>
      Offset(
        position.dx,
        maxHeight - radius,
      );
}
