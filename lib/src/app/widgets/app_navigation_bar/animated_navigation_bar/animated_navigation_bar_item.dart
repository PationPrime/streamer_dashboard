part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarItem extends Equatable {
  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final MainAxisAlignment mainAxisAlignment;

  const AnimatedNavigationBarItem({
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  List<Object?> get props => [
        title,
        leftIcon,
        rightIcon,
        mainAxisAlignment,
      ];
}
