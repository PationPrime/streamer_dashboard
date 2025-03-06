import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../../global_scroll_notification_observer/global_scroll_notification_observer.dart';

class BouncyButtonWrapper extends StatefulWidget {
  final bool forceCancelSelectionOnMove;
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onSecondaryTap;
  final Duration? animationDuration;
  final double scaleFactor;

  const BouncyButtonWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onSecondaryTap,
    this.forceCancelSelectionOnMove = true,
    this.animationDuration,
    this.scaleFactor = 0.98,
  });

  @override
  State<BouncyButtonWrapper> createState() => _BouncyButtonWrapperState();
}

class _BouncyButtonWrapperState extends State<BouncyButtonWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bouncyAnimationController;
  late final Animation<double> _bouncyAnimation;

  void _initAnimation() {
    _bouncyAnimationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 50),
      vsync: this,
    );

    _bouncyAnimation = Tween<double>(
      begin: 1,
      end: widget.scaleFactor,
    ).animate(
      CurvedAnimation(
        parent: _bouncyAnimationController,
        curve: Curves.easeIn,
      ),
    );
  }

  void _onPointerDown() {
    if (!mounted) {
      return;
    }
    _bouncyAnimationController.forward();
  }

  void _onPointerUp() {
    if (!mounted) {
      return;
    }
    _bouncyAnimationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _bouncyAnimationController.dispose();
    super.dispose();
  }

  final _buttonKey = GlobalKey();

  bool _buttonContainsPointer = false;

  void _checkPointerMoveAway(
    Offset pointerPosition,
    bool isAnythingScrolling,
  ) {
    if (!mounted) {
      return;
    }

    if (isAnythingScrolling) {
      _buttonContainsPointer = false;
      _bouncyAnimationController.reverse();
    } else {
      final renderBox =
          _buttonKey.currentContext?.findRenderObject() as RenderBox?;

      final boxPosition = renderBox?.localToGlobal(Offset.zero);

      if (boxPosition is Offset &&
          pointerPosition.dy >= boxPosition.dy &&
          boxPosition.dy + renderBox!.size.height >= pointerPosition.dy &&
          boxPosition.dx <= pointerPosition.dx &&
          boxPosition.dx + renderBox.size.width >= pointerPosition.dx) {
        _buttonContainsPointer = true;

        if (!_bouncyAnimationController.isAnimating) {
          _bouncyAnimationController.forward();
        }
      } else {
        _buttonContainsPointer = false;
        _bouncyAnimationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Listener(
          key: _buttonKey,
          onPointerMove: (event) {
            final isAnythingScrolling =
                GlobalScrollNotificationProvider.of(context)
                        ?.isAnythinScrolling ??
                    false;

            _checkPointerMoveAway(
              event.position,
              isAnythingScrolling,
            );
          },
          onPointerDown: (event) {
            _buttonContainsPointer = true;
            _onPointerDown();
          },
          onPointerUp: (event) {
            _onPointerUp();
            if (_buttonContainsPointer) {
              widget.onTap?.call();
            }
          },
          child: ScaleTransition(
            scale: _bouncyAnimation,
            child: Container(
              color: context.color.transparent,
              child: widget.child,
            ),
          ),
        ),
      );
}
