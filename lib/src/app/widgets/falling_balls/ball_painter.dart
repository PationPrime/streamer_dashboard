part of 'falling_balls.dart';

class BallLeafRenderObjectWidget extends LeafRenderObjectWidget {
  final AnimationController controller;
  final double minBallRadius;
  final double maxBallRadius;

  const BallLeafRenderObjectWidget({
    super.key,
    required this.controller,
    required this.minBallRadius,
    required this.maxBallRadius,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => BallLeafRenderBox(
        controller: controller,
        minBallRadius: minBallRadius,
        maxBallRadius: maxBallRadius,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant BallLeafRenderBox renderObject,
  ) =>
      renderObject
        ..minBallRadius = minBallRadius
        ..maxBallRadius = maxBallRadius;
}

class BallLeafRenderBox extends RenderBox with BallPhysics {
  bool _initialized = false;
  Size? _size;

  late AnimationController _controller;

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

      // if (_figureRect is RRect) {
      //   _handleShapeCollisions(ball, _figureRect!);
      // }

      /// Check with other ball collisions
      for (final otherBall in balls) {
        if (ball != otherBall && _checkBallsCollision(ball, otherBall)) {
          _resolveBallsCollision(ball, otherBall);
        }
      }

      // Обрабатываем столкновение с трапецией

      _updateBallCollisionWithShape(
        ball,
        size,
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
    if (balls.length > 4) return;

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
      Duration(seconds: 1),
      () => _spawnBall(size),
    );
  }

  BallLeafRenderBox({
    required AnimationController controller,
    required double minBallRadius,
    required double maxBallRadius,
  })  : _controller = controller,
        _minBallRadius = minBallRadius,
        _maxBallRadius = maxBallRadius;

  @override
  void performLayout() {
    size = constraints.biggest;
    _size = size;

    if (!_initialized) {
      _initListener();
      _initialized = true;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final Path trapezoidPath = Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + size.width, offset.dy)
      ..lineTo(
        offset.dx + size.width - 100,
        offset.dy + size.height,
      )
      ..lineTo(
        offset.dx + 100,
        size.height + offset.dy,
      )
      ..close();

    canvas.drawPath(
      trapezoidPath,
      Paint()..color = Colors.white,
    );

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
