part of 'falling_balls.dart';

class BallPainter extends CustomPainter {
  final List<Ball> balls;

  const BallPainter({
    required this.balls,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.redAccent;

    for (final ball in balls) {
      canvas.drawCircle(ball.position, ball.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
