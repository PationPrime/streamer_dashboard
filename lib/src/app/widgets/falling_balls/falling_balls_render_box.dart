part of 'falling_balls.dart';

class _FallingBallsRenderBox extends RenderBox with BallPhysics {
  bool _initialized = false;
  Size? _size;

  late AnimationController _controller;

  late bool _showCollisionShape;
  bool get showCollisionShape => _showCollisionShape;

  set showCollisionShape(bool value) {
    if (_showCollisionShape == value) return;
    _showCollisionShape = value;
    markNeedsPaint();
  }

  late double _minBallRadius;
  double get minBallRadius => _minBallRadius;

  set minBallRadius(double value) {
    if (_minBallRadius == value) return;
    _minBallRadius = value;
    markNeedsPaint();
  }

  late double _maxBallRadius;
  double get maxBallRadius => _maxBallRadius;

  set maxBallRadius(double value) {
    if (_maxBallRadius == value) return;
    _maxBallRadius = value;
    markNeedsPaint();
  }

  late double _bottomMargin;
  double get bottomMargin => _bottomMargin;

  set bottomMargin(double value) {
    if (_bottomMargin == value) return;
    _bottomMargin = value;
    markNeedsPaint();
  }

  set controller(AnimationController value) {
    if (_controller == value) return;
    _controller = value;
    markNeedsPaint();
  }

  void _updateBalls(Size size) {
    for (final ball in balls) {
      /// Position update depends on velocity
      ball.position += ball.velocity;

      /// Gravity
      ball.velocity = _gravity(
        velocity: ball.velocity,
      );

      /// Collision with the bottom constraint (maxHeight value)
      if (ball.position.dy + ball.radius > size.height) {
        ball.position = _updatePosition(
          position: ball.position,
          maxHeight: size.height,
          radius: ball.radius,
          maxWidth: size.width,
        );

        ball.velocity = _updateVelocity(
          dx: ball.velocity.dx,
          dy: ball.velocity.dy,
        );
      }

      /// Check with other ball collisions
      for (final otherBall in balls) {
        if (ball != otherBall && _checkBallsCollision(ball, otherBall)) {
          _resolveBallsCollision(ball, otherBall);
        }
      }

      // Обрабатываем столкновение с трапецией

      _updateBallCollisionWithShape(
        ball: ball,
        size: size,
        bottomWidth: _bottomMargin,
      );
    }

    markNeedsPaint();
  }

  void _listener() {
    if (_size is Size) {
      _updateBalls(
        _size!,
      );
    }
  }

  void _initListener() {
    _controller.addListener(
      _listener,
    );

    _controller.repeat();

    if (_size is Size) {
      _spawnBall(_size!);
    }
  }

  void _releaseListener() {
    if (_size is! Size) return;

    _controller.removeListener(
      _listener,
    );
  }

  List<Ball> _balls = [];

  List<Ball> get balls => _balls;
  set balls(List<Ball> values) {
    _balls = balls;

    markNeedsPaint();
  }

  void _spawnBall(Size size) {
    if (balls.length > 30) return;

    final ball = Ball(
      position: _basePosition(
        maxWidth: size.width,
      ),
      velocity: _baseVelocity(),
      radius: _circleRadius(
        min: _minBallRadius,
        max: _maxBallRadius,
      ),
    );

    _balls.add(ball);

    Future.delayed(
      Duration(milliseconds: 500),
      () => _spawnBall(size),
    );
  }

  _FallingBallsRenderBox({
    required AnimationController controller,
    required double minBallRadius,
    required double maxBallRadius,
    required bool showCollisionShape,
    required double bottomMargin,
  })  : _controller = controller,
        _showCollisionShape = showCollisionShape,
        _minBallRadius = minBallRadius,
        _maxBallRadius = maxBallRadius,
        _bottomMargin = bottomMargin;

  @override
  void performLayout() {
    size = constraints.biggest;
    _size = size;

    if (!_initialized) {
      _initListener();
      _initialized = true;
    }
  }

  void _drawCollisionShape({
    required Canvas canvas,
    required Size size,
    required Offset offset,
    required double bottomWidth,
  }) {
    final trapezoidPath = Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + size.width, offset.dy)
      ..lineTo(
        offset.dx + size.width - bottomWidth,
        offset.dy + size.height,
      )
      ..lineTo(
        offset.dx + bottomWidth,
        size.height + offset.dy,
      )
      ..close();

    canvas.drawPath(
      trapezoidPath,
      Paint()..color = Colors.white,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    if (_showCollisionShape) {
      _drawCollisionShape(
        canvas: canvas,
        size: size,
        offset: offset,
        bottomWidth: _bottomMargin,
      );
    }

    final paint = Paint()..color = Colors.redAccent;

    for (final ball in balls) {
      // shift the position of the ball by the offset received from parent
      canvas.drawCircle(offset + ball.position, ball.radius, paint);
    }
  }

  @override
  void detach() {
    if (_initialized) {
      _releaseListener();
    }

    super.detach();
  }
}
