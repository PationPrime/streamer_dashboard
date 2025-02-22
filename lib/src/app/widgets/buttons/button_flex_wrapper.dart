import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class ButtonFlexWrapper extends StatelessWidget {
  final double bottomPaddingValue;
  final Widget Function(BuildContext context, bool isKeyboardVisible) builder;
  final Color? backgroundColor;

  const ButtonFlexWrapper({
    super.key,
    required this.builder,
    this.bottomPaddingValue = 50.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => AnimatedContainer(
          decoration: !isKeyboardVisible
              ? null
              : BoxDecoration(
                  color: backgroundColor ?? context.color.background,
                  border: Border(
                    top: BorderSide(
                      color: context.color.border,
                    ),
                  ),
                ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: isKeyboardVisible ? 15 : 0,
            left: 24,
            right: 24,
          ),
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              builder(context, isKeyboardVisible),
              AnimatedSize(
                duration: const Duration(
                  microseconds: 150,
                ),
                child: SizedBox(
                  height: isKeyboardVisible ? 0 : bottomPaddingValue,
                ),
              ),
            ],
          ),
        ),
      );
}
