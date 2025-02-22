import 'package:flutter/widgets.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class NavigationBarIcon extends StatelessWidget {
  final Widget icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry iconPadding;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Alignment contentAlignment;
  final String? label;
  final Color? labelColor;

  const NavigationBarIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    required this.margin,
    required this.mainAxisAlignment,
    required this.iconPadding,
    required this.borderRadius,
    required this.backgroundColor,
    required this.contentAlignment,
    this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: backgroundColor,
          ),
          height: height,
          width: width,
          alignment: contentAlignment,
          margin: margin,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Padding(
                padding: iconPadding,
                child: icon,
              ),
              if (label is String)
                Text(
                  label!,
                  style: context.text.headline5Medium.copyWith(
                    color: labelColor ?? context.color.primary,
                  ),
                )
            ],
          ),
        ),
      );
}
