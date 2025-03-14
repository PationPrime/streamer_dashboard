import 'package:flutter/material.dart';

import '../../../../app/widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            Flexible(
              child: SimpleWebView(
                url:
                    "https://www.donationalerts.com/widget/lastdonations?alert_type=1,4,6,13,15,11,19,18,17,16,14,32,12&limit=25&token=MzxsVc0dOQRsHf6RGWvW",
              ),
            ),
          ],
        ),
      );
}
