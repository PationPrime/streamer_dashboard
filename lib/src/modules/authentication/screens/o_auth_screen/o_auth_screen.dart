import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class OAuthScreen extends StatefulWidget {
  const OAuthScreen({super.key});

  @override
  State<OAuthScreen> createState() => _OAuthScreenState();
}

class _OAuthScreenState extends State<OAuthScreen> {
  String? authCode;

  // Redirect URI (должен совпадать с указанным в Twitch Developer Console)
  final redirectUri = 'https://streamallin.com/auth/twitch/';

  // URL для авторизации Twitch
  late final twitchAuthUrl =
      'https://id.twitch.tv/oauth2/authorize?client_id=y1ptudhykj24kd960jpnjvzv6uyksc&redirect_uri=$redirectUri&response_type=code&scope=user:read:email';

  @override
  void initState() {
    super.initState();
    _initCefClient();
  }

  Future<void> login() async {}

  Future<void> _initCefClient() async {}

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700, maxHeight: 500),
        child: Material(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: context.color.secondary,
        ),
      );

// Метод для обмена кода на токен
  void exchangeCodeForToken(String code) async {
    final response = await Dio().post(
      'https://id.twitch.tv/oauth2/token',
      data: {
        'client_id': 'YOUR_CLIENT_ID',
        'client_secret': 'YOUR_CLIENT_SECRET',
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      final accessToken = data['access_token'];
      print('Access Token: $accessToken');
    } else {
      print('Error: ${response.data}');
    }
  }
}
