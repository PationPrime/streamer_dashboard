import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

class StreamWidgetsScreen extends StatefulWidget {
  const StreamWidgetsScreen({super.key});

  @override
  State<StreamWidgetsScreen> createState() => _StreamWidgetsScreenState();
}

class _StreamWidgetsScreenState extends State<StreamWidgetsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
