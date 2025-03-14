import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/modules/modules.dart';

class TwitchStreamScreen extends StatelessWidget {
  const TwitchStreamScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Flexible(
              child: TwitchChatWebView(
                url: 'https://www.twitch.tv/popout/pationroute/chat',
              ),
            ),
          ],
        ),
      );
}
