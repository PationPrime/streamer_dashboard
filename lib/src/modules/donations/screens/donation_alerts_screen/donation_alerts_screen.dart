import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../../../app/lang/locale_keys.g.dart';
import '../../../../app/widgets/widgets.dart';

import '../../controllers/controllers.dart';

class DonationAlertsScreen extends StatelessWidget {
  const DonationAlertsScreen({super.key});

  Future<void> _addOrEditLink(
    BuildContext context, {
    String? initialLink,
  }) async {
    final textResponse = await CommonDialog.show(
      context: context,
      title: LocaleKeys.donations_donation_alerts_add_dialog_last_alerts_title
          .tr(),
      description: LocaleKeys
          .donations_donation_alerts_add_dialog_last_alerts_insert_link
          .tr(),
      initialText: initialLink,
    );

    if (textResponse is String && context.mounted) {
      context.read<DonationsController>().addDonationAlerts(
            textResponse,
          );
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DonationsController, DonationsState>(
        builder: (context, donationsController) => Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                LocaleKeys.donations_donation_alerts_title.tr(),
                style: context.text.headline3Bold,
              ),
              const SizedBox(
                height: 10,
              ),
              if (!donationsController.donationAlertsConnected)
                Row(
                  children: [
                    PrimaryButton(
                      title:
                          LocaleKeys.donations_donation_alerts_buttons_add.tr(),
                      height: 35,
                      expanded: false,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      onTap: () async => _addOrEditLink(
                        context,
                      ),
                    ),
                  ],
                )
              else if (donationsController.donationAlertsModel?.widgetWebViewUrl
                  is String)
                Flexible(
                  child: Column(
                    children: [
                      DonationWidgetTitle(
                        title: LocaleKeys
                            .donations_donation_alerts_add_dialog_last_alerts_title
                            .tr(),
                        leftButtonTitle: LocaleKeys
                            .donations_donation_alerts_buttons_edit
                            .tr(),
                        onLeftPressed: () async => _addOrEditLink(
                          context,
                          initialLink: donationsController
                              .donationAlertsModel?.widgetWebViewUrl,
                        ),
                        rigthButtonTitle: LocaleKeys
                            .donations_donation_alerts_buttons_remove
                            .tr(),
                        onRightPressed: () {
                          context
                              .read<DonationsController>()
                              .removeDonationAlertsLink();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: DonationAlertsLastMessagesWidget(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
}
