import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';
import 'package:streamer_dashboard/src/modules/authentication/controllers/authentication_controller/authentication_controller.dart';

import '../../../../app/models/models.dart';
import '../../../../assets_gen/assets.gen.dart';
import '../o_auth_screen/o_auth_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late List<AuthenticationButtonModel> _buttonModels = [];

  void _showAuthenticationDialog() {
    showDialog(
      context: context,
      barrierColor: context.color.background.withOpacity(0.7),
      builder: (context) => Center(child: OAuthScreen()),
    );
  }

  @override
  void initState() {
    super.initState();

    _buttonModels = [
      AuthenticationButtonModel(
        connectTitle: 'Connect',
        disconnectTitle: 'Disconnect',
        icon: Assets.icons.iconTwitch.svg(),
        onTap: _showAuthenticationDialog,
      ),
      AuthenticationButtonModel(
        connectTitle: 'Connect',
        disconnectTitle: 'Disconnect',
        icon: Assets.icons.iconYoutube.svg(),
        onTap: _showAuthenticationDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationController, AuthenticationState>(
        builder: (context, authenticationState) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: _buttonModels.length,
                itemBuilder: (context, index) {
                  final buttonModel = _buttonModels[index];

                  return Row(
                    children: [
                      PrimaryButton(
                        width: 120,
                        title: buttonModel.connectTitle,
                        onTap: buttonModel.onTap,
                        icon: buttonModel.icon,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      );
}
