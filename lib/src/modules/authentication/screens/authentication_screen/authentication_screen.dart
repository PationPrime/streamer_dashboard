import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/shared_controllers.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';
import 'package:streamer_dashboard/src/modules/modules.dart';

import '../../../../app/failure/failure.dart';
import '../../../../app/models/models.dart';
import '../../../../assets_gen/assets.gen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late List<AuthenticationButtonModel> _buttonModels = [];

  Future<void> _showAuthenticationCEFWindow() async {
    final authenticationController = context.read<AuthenticationController>();

    authenticationController.loginTwitchOAuth2(
      onSuccessCallback: () async {
        await context
            .read<TwitchAuthorizationController>()
            .chechAuthorizationState();

        if (!context.mounted) {
          return;
        }

        // ignore: use_build_context_synchronously
        await context
            .read<TwitchStreamerAccountController>()
            .getStreamerProfile();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _buttonModels = [
      AuthenticationButtonModel(
        authProvider: AuthProviders.twitch,
        connectTitle: 'Connect',
        disconnectTitle: 'Disconnect',
        icon: Assets.icons.iconTwitch.svg(),
        onTap: _showAuthenticationCEFWindow,
      ),
    ];
  }

  void _showErrorDialog(
    AuthenticationState authenticationState,
  ) =>
      showDialog(
        context: context,
        builder: (context) => ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Material(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: context.color.secondary,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Twitch authorization failed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.color.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (authenticationState.twitchConnetionFailure?.message
                      is String)
                    Flexible(
                      child: Text(
                        'Error message: ${authenticationState.twitchConnetionFailure?.message}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.color.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    width: 120,
                    title: 'Close',
                    onTap: Navigator.of(context).maybePop,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<AuthenticationController, AuthenticationState>(
        listenWhen: (previous, current) =>
            previous.twitchConnetionFailure != current.twitchConnetionFailure &&
            current.twitchConnetionFailure is Failure,
        listener: (context, authenticationState) async {
          if (authenticationState.twitchConnetionFailure is Failure) {
            _showErrorDialog(authenticationState);
            await context.read<AuthenticationController>().forceCloseCEF();
          }
        },
        builder: (context, authenticationState) => Scaffold(
          body: authenticationState is AuthenticationInitialState
              ? Center(
                  child: const CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverList.separated(
                        itemCount: _buttonModels.length,
                        itemBuilder: (context, index) {
                          final buttonModel = _buttonModels[index];

                          return Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: buttonModel.icon,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        buttonModel.authProvider,
                                        style: context.text.headline4Medium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  PrimaryButton(
                                    width: 120,
                                    height: 40,
                                    padding: EdgeInsets.zero,
                                    title: buttonModel.connectTitle,
                                    onTap: buttonModel.onTap,
                                  ),
                                ],
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
        ),
      );
}
