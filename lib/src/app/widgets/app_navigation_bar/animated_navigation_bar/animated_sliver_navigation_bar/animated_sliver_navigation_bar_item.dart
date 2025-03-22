part of 'animated_sliver_navigation_bar.dart';

class AnimatedSliverNavigationBarItem extends StatelessWidget {
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String title;
  final void Function()? onPressed;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? titleStyle;
  final double height;
  final double width;
  final bool selected;
  final MainAxisAlignment mainAxisAlignment;
  final BorderRadius borderRadius;

  const AnimatedSliverNavigationBarItem({
    super.key,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    required this.title,
    this.titlePadding = const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    this.titleStyle,
    this.height = 40,
    this.width = double.infinity,
    this.selected = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.borderRadius = const BorderRadius.only(),
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: MaterialButton(
          elevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          hoverColor: selected ? context.color.transparent : null,
          splashColor: context.color.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          onPressed: onPressed,
          padding: contentPadding,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (leftIcon is Widget) leftIcon!,
              Padding(
                padding: leftIcon is Widget || rightIcon is Widget
                    ? titlePadding
                    : EdgeInsets.zero,
                child: Text(
                  title,
                  style: titleStyle ??
                      context.text.headline5SemiBold.copyWith(
                        color: context.color.primary,
                      ),
                ),
              ),
              if (rightIcon is Widget) rightIcon!,
            ],
          ),
        ),
      );
}
