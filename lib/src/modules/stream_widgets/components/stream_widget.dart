import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';

import '../../../app/widgets/widgets.dart';

class StreamWidget extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Widget widget;
  final VoidCallback? onTap;

  const StreamWidget({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 440,
            width: 350,
            child: widget,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: context.text.headline4Medium,
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            width: 200,
            onTap: onTap,
            title: buttonTitle,
          ),
        ],
      );
}
