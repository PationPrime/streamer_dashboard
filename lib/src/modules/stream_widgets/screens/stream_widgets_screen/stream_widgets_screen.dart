import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

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
            Positioned.fill(
              child: Center(
                child: SizedBox(
                  height: 500,
                  width: 450,
                  child: FallingBalls(),
                ),
              ),
            ),
          ],
        ),
      );
}
