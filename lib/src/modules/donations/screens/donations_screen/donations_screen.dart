import 'package:flutter/material.dart';

import '../../../../app/widgets/widgets.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SimpleWebView(
          url: '',
        ),
      );
}
