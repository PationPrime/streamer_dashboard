import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/widgets/buttons/buttons.dart';

class DonationWidgetTitle extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback? onPressed;

  const DonationWidgetTitle({
    super.key,
    required this.title,
    required this.buttonTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.text.headline4SemiBold,
          ),
          const SizedBox(
            width: 10,
          ),
          PrimaryButton(
            onTap: onPressed,
            height: 35,
            title: buttonTitle,
            expanded: false,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        ],
      );
}
