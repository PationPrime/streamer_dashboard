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
            Positioned(
              right: 10,
              bottom: 100,
              child: SizedBox(
                height: 400,
                width: 350,
                child: FallingBalls(),
              ),
            ),
          ],
        ),
      );
}
