import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/modules/modules.dart';

import '../../controllers/twitch_live_stream_controller/twitch_live_stream_controller.dart';

class TwitchStreamScreen extends StatelessWidget {
  const TwitchStreamScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => TwitchLiveStreamController(
          twitchStreamerProfileController:
              context.read<TwitchStreamerAccountController>(),
        ),
        child: const _TwitchStreamScreenView(),
      );
}

class _TwitchStreamScreenView extends StatelessWidget {
  const _TwitchStreamScreenView();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TwitchLiveStreamController, TwitchLiveStreamState>(
        builder: (context, twitchLiveStreamState) => Scaffold(
          body: Center(
            child: twitchLiveStreamState.loading
                ? CircularProgressIndicator(
                    strokeWidth: 1.5,
                  )
                : twitchLiveStreamState.failure != null
                    ? Text(
                        twitchLiveStreamState.failure?.message ??
                            'Something went wrong!',
                        style: context.text.headline3Bold,
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        children: [
                          if (twitchLiveStreamState.chatUrl is String)
                            Flexible(
                              child: TwitchChatWebView(
                                url: twitchLiveStreamState.chatUrl!,
                              ),
                            ),
                        ],
                      ),
          ),
        ),
      );
}
