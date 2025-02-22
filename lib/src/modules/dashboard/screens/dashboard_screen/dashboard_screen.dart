import 'dart:math';

import 'package:flutter/material.dart';

import '../../components/components.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: DonationAlertsWidgetWebview(),
          ),
        ],
      ),
      //   slivers: [
      // SliverList.separated(
      //   itemBuilder: (context, index) => Container(
      //     height: 100,
      //     color: Color.fromRGBO(
      //       Random().nextInt(255),
      //       Random().nextInt(255),
      //       Random().nextInt(255),
      //       1,
      //     ),
      //   ),
      //   separatorBuilder: (_, __) => const SizedBox(
      //     height: 15,
      //   ),
      //   itemCount: 100,
      // )
      //   ],
      // ),
    );
  }
}
