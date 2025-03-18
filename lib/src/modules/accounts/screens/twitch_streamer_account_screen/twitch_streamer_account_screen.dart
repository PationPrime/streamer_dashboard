import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';
import 'package:streamer_dashboard/src/app/shared_controllers/shared_controllers.dart';
import 'package:streamer_dashboard/src/app/widgets/widgets.dart';
import 'package:streamer_dashboard/src/modules/accounts/controllers/controllers.dart';

import '../../../../app/models/models.dart';
import '../../../../app/shared_controllers/authorization_controllers/base_authorization_controller/base_authorization_controller.dart';

class TwitchStreamerAccountScreen extends StatelessWidget {
  const TwitchStreamerAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TwitchAuthorizationController, BaseAuthorizationState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, twitchAuthorizationState) {
          if (twitchAuthorizationState is Unauthorized) {
            context.read<TwitchStreamerAccountController>().clearProfileState();
          }
        },
        builder: (context, twitchAuthorizationState) => BlocBuilder<
            TwitchStreamerAccountController, TwitchStreamerAccountState>(
          builder: (context, twitchStreamerProfileState) =>
              twitchStreamerProfileState.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : twitchStreamerProfileState.profileModel is! TwitchUserModel
                      ? const SizedBox()
                      : Container(
                          decoration: BoxDecoration(
                            color: context.color.background,
                            boxShadow: [
                              BoxShadow(
                                color: context.color.mainBlack.withAlpha(
                                  20,
                                ),
                                spreadRadius: 5,
                                blurRadius: 5,
                              )
                            ],
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          margin: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (twitchStreamerProfileState
                                  .profileModel?.profileImageUrl is String)
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ClipOval(
                                    child: Image.network(
                                      twitchStreamerProfileState
                                          .profileModel!.profileImageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: 14,
                              ),
                              if (twitchStreamerProfileState
                                  .profileModel?.displayName is String)
                                Text(
                                  '${twitchStreamerProfileState.profileModel!.displayName}',
                                  style: context.text.headline4SemiBold,
                                ),
                              const SizedBox(
                                width: 14,
                              ),
                              const Spacer(),
                              PrimaryButton(
                                expanded: false,
                                title: LocaleKeys.accounts_buttons_log_out.tr(),
                                height: 35,
                                buttonColor: context.color.alert,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                borderRadius: 10,
                                onTap: context
                                    .read<TwitchAuthorizationController>()
                                    .signOut,
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
        ),
      );
}
