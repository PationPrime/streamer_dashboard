import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamer_dashboard/src/app/widgets/buttons/buttons.dart';

import 'package:streamer_dashboard/src/modules/modules.dart';

import '../../../../app/failure/failure.dart';

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
          body: streamWidgetsState.isProcessing is Failure
              ? Center(
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                  ),
                )
              : streamWidgetsState.failure is Failure
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Something went wrong!'),
                          if (streamWidgetsState.failure?.message != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text(
                                '${streamWidgetsState.failure?.message}',
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: PrimaryButton(
                              enabled: !streamWidgetsState.isProcessing,
                              onTap: context
                                  .read<StreamWidgetsController>()
                                  .retryInit,
                              title: 'Retry',
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        children: [
                          SubsGlassWidget(
                            onTap: (widgetUrlPath) async {
                              final url =
                                  '${streamWidgetsState.webAppHostingUri}/$widgetUrlPath';

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
