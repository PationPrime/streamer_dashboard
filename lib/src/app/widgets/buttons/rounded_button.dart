import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double radius;
  final Widget? icon;

  const RoundedButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.radius = 15,
    this.icon,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: backgroundColor ?? context.color.border,
          radius: radius,
          child: Center(
            child: icon ?? const Icon(Icons.close),
          ),
        ),
      );
}
