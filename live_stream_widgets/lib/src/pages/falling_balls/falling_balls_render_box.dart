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
  }

  void _releaseListener() {
    if (_size is! Size) return;

    _controller.removeListener(
      _listener,
    );
  }

  int _ballIndex = 0;

  List<SubsGlassBallModel> _subsGlassBallModels = [];

  set subsGlassBallModels(List<SubsGlassBallModel> value) {
    if (listEquals(_subsGlassBallModels, value)) return;

    _subsGlassBallModels = value;

    debugPrint(
      '_subsGlassBallModels: $_subsGlassBallModels',
    );

    if (_size is Size) {
      _spawnBall(_size!);
    }
  }

  List<Ball> _balls = [];

  List<Ball> get balls => _balls;
  set balls(List<Ball> values) {
    _balls = balls;

    markNeedsPaint();
  }

  void _spawnBall(Size size) {
    if (_ballIndex == _subsGlassBallModels.length - 1) {
      _ballIndex = 0;
      return;
    }

    final subsGlassBallModel = _subsGlassBallModels[_ballIndex];

    final ball = Ball(
      position: _basePosition(
        maxWidth: size.width,
      ),
      velocity: _baseVelocity(),
      radius: subsGlassBallModel.radius,
      imageUrl: subsGlassBallModel.imageUrl,
    );

    _balls.add(ball);

    _ballIndex++;

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
    required List<SubsGlassBallModel> subsGlassBallModels,
  })  : _controller = controller,
        _showCollisionShape = showCollisionShape,
        _minBallRadius = minBallRadius,
        _maxBallRadius = maxBallRadius,
        _bottomMargin = bottomMargin,
        _subsGlassBallModels = subsGlassBallModels;

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
      Paint()..color = Colors.greenAccent,
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

    for (final ball in balls) {
      final center = offset + ball.position;

      if (ball.image != null) {
        // Сохраняем текущий слой и обрезаем область до круга
        canvas.saveLayer(
          Rect.fromCircle(
            center: center,
            radius: ball.radius,
          ),
          Paint(),
        );

        // Обрезаем область в форме круга
        Path path = Path()
          ..addOval(
            Rect.fromCircle(
              center: center,
              radius: ball.radius,
            ),
          );
        canvas.clipPath(path);

        // Рисуем изображение внутри ограниченного круга
        paintImage(
          canvas: canvas,
          rect: Rect.fromCircle(
            center: center,
            radius: ball.radius,
          ),
          image: ball.image!,
          fit: BoxFit.cover,
        );

        // Восстанавливаем исходный слой
        canvas.restore();
      } else {
        // Если изображение еще не загрузилось, рисуем просто цветной круг-заглушку
        final paint = Paint()..color = Colors.grey;
        canvas.drawCircle(
          center,
          ball.radius,
          paint,
        );
      }
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

   // context_settings.persist_session_cookies = true;
    // std::string cache_path_std = "D:\\CEF_CACHE";
        // cef_string_t cef_cache_path;
        // cef_string_utf8_to_utf16(cache_path_std.c_str(), cache_path_std.length(), &cef_cache_path);
        // context_settings.cache_path = cef_cache_path;