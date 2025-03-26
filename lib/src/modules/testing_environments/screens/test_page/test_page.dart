import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/router/navigation_path.dart';
import 'package:streamer_dashboard/src/app/widgets/buttons/buttons.dart';

import '../../../../app/storage/storage.dart';
import '../logs_screen/logs_screen.dart';

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
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            _SectionTitle(
              title: 'Testing screens',
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              expanded: false,
              height: 35,
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              onTap: () => context.goNamed(
                NavigationPath.logs,
              ),
              title: 'Go to Logs',
            ),
            const SizedBox(
              height: 20,
            ),
            _SectionTitle(
              title: 'Local storage',
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              expanded: false,
              height: 35,
              buttonColor: context.color.cancel,
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              onTap: () async {
                await AppSecureStorage.instance.deleteAllStorageValues();
              },
              title: 'Clear all data',
            ),
          ],
        ),
      );
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Flexible(
            child: Divider(),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: context.text.headline3SemiBold,
          ),
          const SizedBox(
            width: 10,
          ),
          const Flexible(
            child: Divider(),
          ),
        ],
      );
}
