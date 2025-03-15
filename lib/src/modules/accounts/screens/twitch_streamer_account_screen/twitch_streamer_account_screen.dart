import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/shared_controllers.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';

import '../../../../app/models/models.dart';

class TwitchStreamerAccountScreen extends StatelessWidget {
  final TwitchUserModel profileModel;

  const TwitchStreamerAccountScreen({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.color.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (profileModel.profileImageUrl is String)
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipOval(
                    child: Image.network(
                      profileModel.profileImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(
                height: 14,
              ),
              if (profileModel.displayName is String)
                Text('${profileModel.displayName}'),
              const SizedBox(
                height: 14,
              ),
              PrimaryButton(
                width: 120,
                title: 'Log out',
                height: 35,
                buttonColor: context.color.alert,
                padding: EdgeInsets.zero,
                onTap: context.read<TwitchAuthorizationController>().signOut,
              )
            ],
          ),
        ),
      );
}
