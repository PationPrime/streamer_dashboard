import 'package:flutter/material.dart';

import '../../../../app/widgets/widgets.dart';

class LiveStreamsScreen extends StatefulWidget {
  const LiveStreamsScreen({super.key});

  @override
  State<LiveStreamsScreen> createState() => _LiveStreamsScreenState();
}

class _LiveStreamsScreenState extends State<LiveStreamsScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 800,
              width: 500,
              child: SimpleWebView(
                url: "https://www.twitch.tv/popout/pationprime/chat",
              ),
            ),
          ],
        ),
      );
}
