import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:live_stream_widgets/src/app/subs_glass_widget_controller/subs_glass_widget_controller.dart';

import 'bridge_server_controller/bridge_server_controller.dart';
import 'router/app_go_router.dart';

class StreamWidgetsApp extends StatefulWidget {
  const StreamWidgetsApp({super.key});

  @override
  State<StreamWidgetsApp> createState() => _StreamWidgetsAppState();
}

class _StreamWidgetsAppState extends State<StreamWidgetsApp> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SubsGlassWidgetController(),
          ),
          BlocProvider(
            create: (context) => BridgeServerController(
              FlutterSecureStorage(),
              subsGlassWidgetController:
                  context.read<SubsGlassWidgetController>(),
            ),
          ),
        ],
        child: _StreamWidgetsAppView(),
      );
}

class _StreamWidgetsAppView extends StatelessWidget {
  const _StreamWidgetsAppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stream Widgets',
      debugShowCheckedModeBanner: false,
      routerConfig: AppGoRouter.router,
    );
  }
}
