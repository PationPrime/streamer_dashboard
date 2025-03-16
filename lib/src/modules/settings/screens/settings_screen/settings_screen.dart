import 'package:flutter/material.dart';

import '../../../test_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final redirectUri = 'https://streamallin.com/auth/twitch/';

    // URL для авторизации Twitch
    late final twitchAuthUrl =
        'https://id.twitch.tv/oauth2/authorize?client_id=y1ptudhykj24kd960jpnjvzv6uyksc&redirect_uri=$redirectUri&response_type=code&scope=user:read:email';

    return Scaffold(
      body: TestWebViewPage(
        url: twitchAuthUrl,
      ),
    );
  }
}
