import 'package:flutter/material.dart';

import '../widgets.dart';
import 'buttons.dart';

class SendButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double width;
  final double height;
  final bool enabled;

  const SendButton({
    super.key,
    this.onTap,
    this.width = 40,
    this.height = double.infinity,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) => BouncyButtonWrapper(
        onTap: enabled ? onTap : null,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
              // child: Assets.icons.iconSend.svg(
              //   color: enabled ? context.color.primary : context.color.disabled,
              // ),
              ),
        ),
      );
}
