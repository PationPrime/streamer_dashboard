part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarSelectionStyle extends Equatable {
  final Color color;
  final BorderRadius borderRadius;
  final Duration animationDuration;

  const AnimatedNavigationBarSelectionStyle({
    this.color = const Color.fromARGB(77, 168, 157, 157),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(20),
    ),
    this.animationDuration = const Duration(
      milliseconds: 300,
    ),
  });

  @override
  List<Object?> get props => [
        color,
        borderRadius,
        animationDuration,
      ];
}
