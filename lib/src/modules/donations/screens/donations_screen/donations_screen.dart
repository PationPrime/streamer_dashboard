import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/modules/donations/screens/donation_alerts_screen/donation_alerts_screen.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: DonationAlertsScreen(),
      );
}
