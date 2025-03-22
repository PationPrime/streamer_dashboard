part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarSelectionStyle extends Equatable {
  final Color color;
  final BorderRadius borderRadius;
  final Duration animationDuration;

  const AnimatedNavigationBarSelectionStyle({
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    this.animationDuration = const Duration(
      milliseconds: 300,
    ),
  });

  AnimatedNavigationBarSelectionStyle copyWith({
    Color? color,
  }) =>
      AnimatedNavigationBarSelectionStyle(
        color: color ?? this.color,
      );

  @override
  List<Object?> get props => [
        color,
        borderRadius,
        animationDuration,
      ];
}
