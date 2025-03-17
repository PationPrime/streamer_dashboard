part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarItemWidget extends StatelessWidget {
  final double heigth;
  final AnimatedNavigationBarItem barItem;
  final EdgeInsets contentPadding;

  const AnimatedNavigationBarItemWidget({
    super.key,
    required this.barItem,
    this.heigth = 35,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
    ),
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Padding(
          padding: contentPadding,
          child: Row(
            children: [
              if (barItem.leftIcon is Widget) barItem.leftIcon!,
              Text(
                barItem.title,
                style: context.text.headline4Medium,
              ),
              if (barItem.rightIcon is Widget) barItem.rightIcon!,
            ],
          ),
        ),
      );
}
