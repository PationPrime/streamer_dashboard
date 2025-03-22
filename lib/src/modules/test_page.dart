import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../app/widgets/app_navigation_bar/animated_navigation_bar/animated_sliver_navigation_bar/animated_sliver_navigation_bar.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
        child: Text(
          'Test page',
          style: context.text.headline3SemiBold,
        ),
      ));
}
