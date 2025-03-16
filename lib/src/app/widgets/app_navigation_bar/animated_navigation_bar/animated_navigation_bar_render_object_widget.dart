part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarRenderObjectWidget
    extends MultiChildRenderObjectWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Animation<double> highlightAnimation;
  final Axis barAxis;

  const AnimatedNavigationBarRenderObjectWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required super.children,
    required this.highlightAnimation,
    this.barAxis = Axis.vertical,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      AnimatedNavigationBarRenderBox(
        onItemSelected: onItemSelected,
        highlightAnimation: highlightAnimation,
        barAxis: barAxis,
      )..selectedIndex = selectedIndex;

  @override
  void updateRenderObject(
    BuildContext context,
    AnimatedNavigationBarRenderBox renderObject,
  ) =>
      renderObject
        ..selectedIndex = selectedIndex
        ..onItemSelected = onItemSelected
        ..highlightAnimation = highlightAnimation
        ..barAxis = barAxis;
}
