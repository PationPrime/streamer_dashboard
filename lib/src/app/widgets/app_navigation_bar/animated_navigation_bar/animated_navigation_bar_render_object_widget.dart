part of 'animated_navigation_bar.dart';

class AnimatedNavigationBarRenderObjectWidget
    extends MultiChildRenderObjectWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Animation<double> highlightAnimation;
  final Axis barAxis;
  final AnimatedNavigationBarSelectionStyle selectionStyle;

  const AnimatedNavigationBarRenderObjectWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required super.children,
    required this.highlightAnimation,
    this.barAxis = Axis.vertical,
    required this.selectionStyle,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      AnimatedNavigationBarRenderBox(
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
        highlightAnimation: highlightAnimation,
        barAxis: barAxis,
        selectionStyle: selectionStyle,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    AnimatedNavigationBarRenderBox renderObject,
  ) =>
      renderObject
        ..selectedIndex = selectedIndex
        ..onItemSelected = onItemSelected
        ..highlightAnimation = highlightAnimation
        ..barAxis = barAxis
        ..selectionStyle = selectionStyle;
}
