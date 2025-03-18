import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import 'package:streamer_dashboard/src/modules/modules.dart';

import '../../../../app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';
import '../../../../app/shared_controllers/shared_controllers.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TwitchAuthorizationController>().chechAuthorizationState();
    context.read<TwitchStreamerAccountController>().getStreamerProfile();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TwitchAuthorizationController, BaseAuthorizationState>(
        builder: (context, twitchAuthorizationState) => Scaffold(
          body: twitchAuthorizationState is! Authorized
              ? Center(
                  child: Text(
                    'No one is connected',
                    style: context.text.headline3Bold,
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 5,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TwitchStreamerAccountScreen(),
                      const SizedBox(
                        height: 10,
                      ),
                      TwitchStreamerAccountScreen(),
                      const SizedBox(
                        height: 10,
                      ),
                      TwitchStreamerAccountScreen(),
                      const SizedBox(
                        height: 10,
                      ),
                      TwitchStreamerAccountScreen(),
                      const SizedBox(
                        height: 10,
                      ),
                      TwitchStreamerAccountScreen(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
        ),
      );
}
