import 'package:flutter/material.dart';

import 'router/app_go_router.dart';

class StreamWidgetsApp extends StatefulWidget {
  const StreamWidgetsApp({super.key});

  @override
  State<StreamWidgetsApp> createState() => _StreamWidgetsAppState();
}

class _StreamWidgetsAppState extends State<StreamWidgetsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stream Widgets',
      debugShowCheckedModeBanner: false,
      routerConfig: AppGoRouter.router,
    );
  }
}
