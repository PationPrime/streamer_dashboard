import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'custom_overlay_base_controller.dart';
part 'custom_overlay_base_state.dart';
part 'custom_overlay_base_position.dart';

abstract class CustomOverlayBase extends StatefulWidget {
  final CustomOverlayBaseController controller;
  final Widget child;
  final Duration animationDuration;
  final bool closeOnOutsideTap;
  final double childTopPaddingValue;
  final void Function(PointerHoverEvent)? onHover;
  final Color dropDownBackgroundColor;
  final CustomOverlayPosition rtOverlayPosition;

  const CustomOverlayBase({
    super.key,
    required this.controller,
    required this.child,
    this.animationDuration = const Duration(
      milliseconds: 10,
    ),
    this.closeOnOutsideTap = false,
    this.childTopPaddingValue = 20,
    this.onHover,
    this.dropDownBackgroundColor = Colors.redAccent,
    this.rtOverlayPosition = CustomOverlayPosition.bottom,
  });
}
