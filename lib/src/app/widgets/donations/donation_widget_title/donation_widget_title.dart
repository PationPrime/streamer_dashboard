import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/widgets/buttons/buttons.dart';

class DonationWidgetTitle extends StatelessWidget {
  final String title;
  final String leftButtonTitle;
  final String rigthButtonTitle;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const DonationWidgetTitle({
    super.key,
    required this.title,
    required this.leftButtonTitle,
    required this.rigthButtonTitle,
    this.onLeftPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            title,
            style: context.text.headline4SemiBold,
          ),
          const SizedBox(
            width: 10,
          ),
          const Spacer(),
          PrimaryButton(
            onTap: onLeftPressed,
            height: 35,
            title: leftButtonTitle,
            buttonColor: context.color.active,
            expanded: false,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          PrimaryButton(
            onTap: onRightPressed,
            height: 35,
            title: rigthButtonTitle,
            buttonColor: context.color.cancel,
            expanded: false,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
        ],
      );
}
