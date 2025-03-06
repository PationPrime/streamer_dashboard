import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class UnauthorizedBanner extends StatelessWidget {
  final String title;
  final Widget? icon;
  final String? description;

  const UnauthorizedBanner({
    super.key,
    required this.title,
    this.icon,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          const SizedBox(
            height: 20,
          ),
        if (icon != null) icon!,
        const SizedBox(
          height: 14,
        ),
        Text(
          title,
          style: context.text.headline1Medium,
        ),
      ],
    );
  }
}
