part of 'falling_balls.dart';

class BallLeafRenderObjectWidget extends LeafRenderObjectWidget {
  final List<Ball> balls;

  const BallLeafRenderObjectWidget({
    super.key,
    required this.balls,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => BallLeafRenderBox(
        balls: balls,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant BallLeafRenderBox renderObject,
  ) =>
      renderObject..balls = balls;
}

class BallLeafRenderBox extends RenderBox {
  late final _appLogger = AppLogger(where: '$this');

  late List<Ball> _balls;

  List<Ball> get balls => _balls;
  set balls(List<Ball> values) {
    _balls = balls;

    markNeedsPaint();
  }

  BallLeafRenderBox({
    required List<Ball> balls,
  }) : _balls = balls;

  @override
  void performLayout() => size = constraints.biggest;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final paint = Paint()..color = Colors.redAccent;

    for (final ball in balls) {
      canvas.drawCircle(ball.position, ball.radius, paint);
    }

    print(context.canvas.getLocalClipBounds());
  }
}
