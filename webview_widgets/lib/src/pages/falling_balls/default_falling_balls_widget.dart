import 'package:flutter/material.dart';

import '../../assets_gen/assets.gen.dart';
import 'falling_balls.dart';

class DefaultFallingBallsWidget extends StatefulWidget {
  const DefaultFallingBallsWidget({super.key});

  @override
  State<DefaultFallingBallsWidget> createState() =>
      _DefaultFallingBallsWidgetState();
}

class _DefaultFallingBallsWidgetState extends State<DefaultFallingBallsWidget> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              left: 50,
              child: SizedBox(
                height: 400,
                width: 250,
                child: FallingBalls(
                  bottomMargin: 45,
                ),
              ),
            ),
            Positioned(
              top: 40,
              child: Image.asset(
                Assets.images.plasticTransparentCup.path,
                height: 400,
                width: 350,
              ),
            ),
          ],
        ),
      );
}
