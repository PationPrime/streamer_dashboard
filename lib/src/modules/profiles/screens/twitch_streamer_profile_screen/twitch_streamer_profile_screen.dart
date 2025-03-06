import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/shared_controllers.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

import '../../../../app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';
import '../../controllers/twitch_streamer_profile_controller/twitch_streamer_profile_controller.dart';

class TwitchStreamerProfileScreen extends StatelessWidget {
  const TwitchStreamerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TwitchAuthorizationController, BaseAuthorizationState>(
        builder: (context, twitchAuthorizationState) => BlocBuilder<
            TwitchStreamerProfileController, TwitchStreamerProfileState>(
          builder: (context, twitchStreamerProfileState) => Scaffold(
            backgroundColor: context.color.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (twitchStreamerProfileState.profileModel?.profileImageUrl
                      is String)
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: Image.network(
                          twitchStreamerProfileState
                              .profileModel!.profileImageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 14,
                  ),
                  PrimaryButton(
                    width: 120,
                    title: 'Log out',
                    height: 35,
                    buttonColor: context.color.alert,
                    padding: EdgeInsets.zero,
                    onTap:
                        context.read<TwitchAuthorizationController>().signOut,
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
