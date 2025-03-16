part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarItemWidget extends StatelessWidget {
  final double heigth;
  final AnimatedNavigationBarItem barItem;

  const AnimatedNavigationBarItemWidget({
    super.key,
    required this.barItem,
    this.heigth = 35,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 35,
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
      );
}
