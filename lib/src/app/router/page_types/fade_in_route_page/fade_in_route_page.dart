import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeInPage extends CustomTransitionPage {
  FadeInPage({
    super.key,
    Duration duration = const Duration(
      milliseconds: 250,
    ),
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: duration,
        );
}
