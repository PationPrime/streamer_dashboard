import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/shared_controllers.dart';
import 'package:streamer_dashboard/src/modules/modules.dart';

class LiveStreamsScreen extends StatefulWidget {
  const LiveStreamsScreen({super.key});

  @override
  State<LiveStreamsScreen> createState() => _LiveStreamsScreenState();
}

class _LiveStreamsScreenState extends State<LiveStreamsScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TwitchAuthorizationController, BaseAuthorizationState>(
        builder: (context, authorizationState) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    authorizationState is Unauthorized
                        ? const SizedBox()
                        : Flexible(
                            child: SizedBox(
                              height: 800,
                              child: TwitchStreamScreen(
                                  // url:
                                  // "https://www.twitch.tv/popout/pationroute/chat",
                                  // setCookieCallback: () async {
                                  // await _setTwitchCookie();
                                  // },
                                  ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
