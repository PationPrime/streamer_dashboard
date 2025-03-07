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
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          children: [
            Container(
              color: Colors.greenAccent,
              height: 300,
              width: 100,
              child: FallingBalls(),
            ),
          ],
        ),
      );
}
