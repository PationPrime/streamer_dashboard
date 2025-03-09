import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';
import 'package:streamer_dashboard/src/modules/modules.dart';

import '../../../../app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';
import '../../../../app/shared_controllers/shared_controllers.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TwitchAuthorizationController>().chechAuthorizationState();
    context.read<TwitchStreamerProfileController>().getStreamerProfile();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TwitchAuthorizationController, BaseAuthorizationState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, twitchAuthorizationState) {
          if (twitchAuthorizationState is Unauthorized) {
            context.read<TwitchStreamerProfileController>().clearProfileState();
          }
        },
        builder: (context, twitchAuthorizationState) => BlocBuilder<
            TwitchStreamerProfileController, TwitchStreamerProfileState>(
          builder: (context, twitchStreamerProfileState) => Scaffold(
            body: twitchAuthorizationState is! Authorized
                ? Center(
                    child: Text(
                      'No one is connected',
                      style: context.text.headline3Bold,
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: twitchStreamerProfileState.loading
                              ? SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : twitchStreamerProfileState.profileModel
                                      is! TwitchUserModel
                                  ? const SizedBox()
                                  : TwitchStreamerProfileScreen(
                                      profileModel: twitchStreamerProfileState
                                          .profileModel!,
                                    ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      );
}
