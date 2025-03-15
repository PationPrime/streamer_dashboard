import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';

import '../../widgets.dart';
import '../bouncy_button_wrapper/bouncy_button_wrapper.dart';

part 'primary_button_title.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? titleColor;
  final double borderRadius;
  final bool enabled;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final GestureTapCallback? onTap;
  final Widget? customContent;
  final Widget? icon;
  final int? counter;
  final bool expanded;
  final bool loading;
  final Color? onPressHoverColor;
  final bool useSplash;
  final bool? fontWeight500;
  final Color? loadingIndicatorColor;
  final bool forceCancelSelectionOnMove;
  final Alignment contentAlignment;

  const PrimaryButton({
    super.key,
    this.title,
    this.titleStyle,
    this.buttonColor,
    this.height,
    this.borderColor,
    this.titleColor,
    this.expanded = true,
    this.padding = const EdgeInsets.symmetric(vertical: 17),
    this.margin,
    this.width,
    this.borderRadius = 30.0,
    this.enabled = true,
    this.onTap,
    this.icon,
    this.counter,
    this.customContent,
    this.loading = false,
    this.onPressHoverColor,
    this.useSplash = true,
    this.fontWeight500,
    this.loadingIndicatorColor,
    this.forceCancelSelectionOnMove = true,
    this.contentAlignment = Alignment.center,
  });

  static const _kDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) => BouncyButtonWrapper(
        forceCancelSelectionOnMove: forceCancelSelectionOnMove,
        onTap: enabled && !loading ? onTap : null,
        child: AnimatedContainer(
          width: !expanded ? null : width ?? double.infinity,
          height: height,
          margin: margin,
          duration: _kDuration,
          decoration: BoxDecoration(
            color: enabled
                ? buttonColor ?? context.color.cancel
                : context.color.disabled,
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            border: borderColor is! Color
                ? null
                : Border.all(
                    color: borderColor!,
                    width: 1,
                  ),
          ),
          child: loading
              ? Padding(
                  padding: padding,
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: customContent ??
                      Padding(
                        padding: padding,
                        child: title is! String
                            ? const SizedBox()
                            : _PrimaryButtonTitle(
                                fontWeight500: fontWeight500,
                                title: title,
                                titleStyle: titleStyle,
                                icon: icon,
                                titleColor: titleColor,
                                counter: counter,
                              ),
                      ),
                ),
        ),
      );
}
