import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class CustomAnimatedAlertOverlay extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Widget child;

  const CustomAnimatedAlertOverlay({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(
      color: Colors.white,
      height: 0,
      fontSize: 12,
    ),
    required this.child,
  });

  @override
  State<CustomAnimatedAlertOverlay> createState() =>
      _CustomAnimatedAlertOverlayState();
}

class _CustomAnimatedAlertOverlayState extends State<CustomAnimatedAlertOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _transitionContoller;
  late final Animation<Offset> _transitionAnimation;
  late final AnimationController _fadeContoller;
  late final Animation<double> _fadeAnimation;

  OverlayEntry? _alertOverlay;

  void _removeOverlay() {
    _alertOverlay?.remove();
    _alertOverlay = null;
  }

  void _transitionAnimationStatusListener(
    AnimationStatus animationStatus,
  ) {
    if (animationStatus == AnimationStatus.completed) {
      _transitionContoller.stop();
      _transitionContoller.reset();
      _fadeContoller.stop();
      _fadeContoller.reset();
      _removeOverlay();
    }
  }

  void _initController() {
    _transitionContoller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _transitionAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(
        parent: _transitionContoller,
        curve: Curves.ease,
      ),
    );

    _transitionContoller.addStatusListener(
      _transitionAnimationStatusListener,
    );

    _fadeContoller = AnimationController(
      duration: const Duration(
        milliseconds: 1500,
      ),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _fadeContoller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    _transitionContoller.removeStatusListener(
      _transitionAnimationStatusListener,
    );
    _transitionContoller.dispose();
    _fadeContoller.dispose();
    _removeOverlay();

    super.dispose();
  }

  void _onTap(
    Offset position,
  ) {
    if (_alertOverlay is OverlayEntry) return;
    _buildOverlayEntry(context, position);
  }

  void _buildOverlayEntry(BuildContext context, Offset position) {
    _alertOverlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned(
            top: position.dy,
            right: position.dx,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: _transitionAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: context.color.cancel,
                    ),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: widget.textStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    _transitionContoller.forward();
    _fadeContoller.forward();

    if (_alertOverlay is! OverlayEntry) return;

    Overlay.of(context).insert(_alertOverlay!);
  }

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: (event) => _onTap(event.position),
        child: SizedBox(
          child: widget.child,
        ),
      );
}
