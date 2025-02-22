import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system/design_system.dart';

class MeasureWidget {
  static Size measureWidget(
    Widget widget, [
    BoxConstraints constraints = const BoxConstraints(),
  ]) {
    final pipelineOwner = PipelineOwner();

    final rootView = pipelineOwner.rootNode = _MeasurementView(constraints);

    final buildOwner = BuildOwner(
      focusManager: FocusManager(),
    );

    final element = RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      ),
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();

      return rootView.size;
    } finally {
      element.update(
        RenderObjectToWidgetAdapter<RenderBox>(
          container: rootView,
        ),
      );

      buildOwner.finalizeTree();
    }
  }
}

class _MeasurementView extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  final BoxConstraints boxConstraints;

  _MeasurementView(this.boxConstraints);

  @override
  void performLayout() {
    assert(child != null);

    child!.layout(
      boxConstraints,
      parentUsesSize: true,
    );

    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
