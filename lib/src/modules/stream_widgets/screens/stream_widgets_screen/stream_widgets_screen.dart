import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streamer_dashboard/src/modules/modules.dart';

class StreamWidgetsScreen extends StatefulWidget {
  const StreamWidgetsScreen({super.key});

  @override
  State<StreamWidgetsScreen> createState() => _StreamWidgetsScreenState();
}

class _StreamWidgetsScreenState extends State<StreamWidgetsScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StreamWidgetsController, StreamWidgetsState>(
        builder: (context, streamWidgetsState) => Scaffold(
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                SubsGlassWidget(
                  onTap: (widgetUrlPath) async {
                    final url =
                        '${streamWidgetsState.hostingUri}/$widgetUrlPath';
                    print(url);
                    await Clipboard.setData(
                      ClipboardData(
                        text: url,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
