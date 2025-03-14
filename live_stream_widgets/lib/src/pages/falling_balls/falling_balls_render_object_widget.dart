part of 'falling_balls.dart';

class _FallingBallsLeafRenderObjectWidget extends LeafRenderObjectWidget {
  final AnimationController controller;
  final double minBallRadius;
  final double maxBallRadius;
  final bool showCollisionShape;
  final double bottomMargin;
  final List<SubsGlassBallModel> subsGlassBallModels;

  const _FallingBallsLeafRenderObjectWidget({
    required this.controller,
    required this.minBallRadius,
    required this.maxBallRadius,
    required this.showCollisionShape,
    required this.bottomMargin,
    required this.subsGlassBallModels,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _FallingBallsRenderBox(
        controller: controller,
        minBallRadius: minBallRadius,
        maxBallRadius: maxBallRadius,
        showCollisionShape: showCollisionShape,
        bottomMargin: bottomMargin,
        subsGlassBallModels: subsGlassBallModels,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _FallingBallsRenderBox renderObject,
  ) =>
      renderObject
        ..minBallRadius = minBallRadius
        ..maxBallRadius = maxBallRadius
        ..showCollisionShape = showCollisionShape
        ..bottomMargin = bottomMargin
        ..subsGlassBallModels = subsGlassBallModels;
}
