import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class TwitchChatbotScreen extends StatelessWidget {
  const TwitchChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            'Twitch chatbot',
            style: context.text.headline3Medium,
          ),
        ),
      );
}
