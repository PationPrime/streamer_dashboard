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

  /// Collisions
  bool _checkBallsCollision(
    Ball ball1,
    Ball ball2,
  ) {
    final double distance = (ball1.position - ball2.position).distance;
    return distance < (ball1.radius + ball2.radius);
  }

  bool _checkBallLeftWallCollision({
    required Ball ball,
  }) =>
      ball.position.dx - ball.radius < 0;

  bool _checkBallRightWallCollision({
    required Ball ball,
    required double maxWidth,
  }) =>
      ball.position.dx + ball.radius > maxWidth;

  void _resolveBallLeftWallCollision({
    required Ball ball,
  }) {
    ball.position = Offset(
      ball.radius,
      ball.position.dy,
    );

    ball.velocity = Offset(
      -ball.velocity.dx * _defaultVelocityMultiplier,
      ball.velocity.dy,
    );
  }

  /// Функция, возвращающая ближайшую точку на отрезке [lineStartPoint,lineEndPoint] относительно точки [point]
  Offset _closestPointOnLine(
    Offset lineStartPoint,
    Offset lineEndPoint,
    Offset point,
  ) {
    final directedLine = lineEndPoint - lineStartPoint;

    final coef = ((point - lineStartPoint).dot(directedLine)) /
        directedLine.distanceSquared;

    final clampedCoef = coef.clamp(0.0, 1.0);

    return lineStartPoint + directedLine * clampedCoef;
  }

  /// Функция для обработки столкновения шара с наклонной стороной (линейным сегментом)
  void _handleLineCollision(
    Ball ball,
    Offset lineStartPoint,
    Offset lineEndPoint, {
    double restitution = 0.8,
  }) {
    final closest = _closestPointOnLine(
      lineStartPoint,
      lineEndPoint,
      ball.position,
    );

    final dist = (ball.position - closest).distance;

    if (dist < ball.radius) {
      // Вычисляем нормаль столкновения – направление от ближайшей точки к центру шара
      final normal = (ball.position - closest).normalize();
      // Корректируем позицию, чтобы шарик не проникал внутрь: смещаем его до границы
      ball.position = closest + normal * ball.radius;
      // Отражаем скорость вдоль нормали с учетом коэффициента упругости
      final dot = ball.velocity.dot(normal);
      ball.velocity = ball.velocity - normal * (dot * (1 + restitution));
    }
  }

  void _updateBallCollisionWithShape(
    Ball ball,
    Size size,
  ) {
    final topLeft = Offset(
      0,
      0,
    );

    final topRight = Offset(
      size.width,
      0,
    );

    final bottomRight = Offset(
      size.width - 100,
      size.height,
    );

    final bottomLeft = Offset(
      100,
      size.height,
    );

    // Проверяем столкновение с левой наклонной стороной (от topLeft до bottomLeft)
    _handleLineCollision(ball, topLeft, bottomLeft);

    // Проверяем столкновение с правой наклонной стороной (от topRight до bottomRight)
    _handleLineCollision(ball, topRight, bottomRight);

    // Обработка горизонтальной нижней стороны (если требуется)
    // Здесь для примера проверяем нижнюю грань, определённую нижними точками трапеции.
    final bottomY = size.height;

    if (ball.position.dy + ball.radius > bottomY) {
      ball.position = Offset(ball.position.dx, bottomY - ball.radius);
      ball.velocity = Offset(ball.velocity.dx, -ball.velocity.dy * 0.8);
    }
  }

  void _resolveBallRightWallCollision({
    required Ball ball,
    required double maxWidth,
  }) {
    ball.position = Offset(
      maxWidth - ball.radius,
      ball.position.dy,
    );

    ball.velocity = Offset(
      -ball.velocity.dx * _defaultVelocityMultiplier,
      ball.velocity.dy,
    );
  }

  void _resolveBallsCollision(
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

  void _handleShapeCollisions(Ball ball, RRect shape) {
    // Проверка столкновения с левой стороной
    if (ball.position.dx - ball.radius < shape.left) {
      ball.position = Offset(shape.left + ball.radius, ball.position.dy);
      ball.velocity = Offset(-ball.velocity.dx * 0.8, ball.velocity.dy);
    }
    // Правая сторона
    if (ball.position.dx + ball.radius > shape.right) {
      ball.position = Offset(shape.right - ball.radius, ball.position.dy);
      ball.velocity = Offset(-ball.velocity.dx * 0.8, ball.velocity.dy);
    }
    // Нижняя сторона
    if (ball.position.dy + ball.radius > shape.bottom) {
      ball.position = Offset(ball.position.dx, shape.bottom - ball.radius);
      ball.velocity = Offset(ball.velocity.dx, -ball.velocity.dy * 0.8);
    }

    // Обработка углов (пример для нижнего левого угла)
    if (ball.position.dx < shape.left + shape.blRadiusX &&
        ball.position.dy > shape.bottom - shape.blRadiusY) {
      final cornerCenter = Offset(
        shape.left + shape.blRadiusX,
        shape.bottom - shape.blRadiusY,
      );

      final distance = (ball.position - cornerCenter).distance;
      if (distance < ball.radius) {
        // Нормаль столкновения: вектор от центра дуги к центру шара
        final normal = (ball.position - cornerCenter) / distance;
        // Корректируем позицию, чтобы шар не проникал в область угла
        ball.position = cornerCenter + normal * ball.radius;
        // Инвертируем скорость вдоль нормали (с коэффициентом упругости)
        final dot = ball.velocity.dx * normal.dx + ball.velocity.dy * normal.dy;
        ball.velocity = ball.velocity - normal * (dot * 1.8);
      }
    }
    // Аналогичные проверки для правого нижнего угла (и при необходимости для верхних углов)
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
    required double maxWidth,
    required double radius,
  }) =>
      Offset(
        position.dx,
        maxHeight - radius,
      );
}
