import 'package:flutter/material.dart';

import '../app/widgets/app_navigation_bar/animated_navigation_bar/custom_animated_sliver.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _highlightTween;
  late Animation<double> _highlightAnimation;

  void _startAnimation() {
    _animationController.forward(
      from: 0.0,
    );
  }

  void _initAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _highlightTween = Tween<double>(begin: 0, end: 1);

    _highlightAnimation = _highlightTween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _startAnimation();
  }

  void _disposeAnimation() {
    _animationController.dispose();
  }

  int _selectedIndex = 0;

  void _select(int index) {
    _startAnimation();

    setState(
      () => _selectedIndex = index,
    );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  @override
  void dispose() {
    _disposeAnimation();
    super.dispose();
  }

  int? selected;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverList(
              selectedIndex: _selectedIndex,
              highlightAnimation: _highlightAnimation,
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () => _select(
                    index,
                  ),
                  child: Container(
                    height: 50,
                    color: index.isEven ? Colors.blue : Colors.green,
                    alignment: Alignment.center,
                    child: Text(
                      'Item $index',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                childCount: 20,
              ),
            ),
          ],
        ),
      );
}
