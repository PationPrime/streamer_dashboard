import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../../../app/tools/tools.dart';

class TestLogsScreen extends StatefulWidget {
  const TestLogsScreen({super.key});

  @override
  State<TestLogsScreen> createState() => _TestLogsScreenState();
}

class _TestLogsScreenState extends State<TestLogsScreen> {
  late final ScrollController _scrollController;

  late final _rtLogger = AppLogger(where: '$this');

  void _addTestErrorLog() {
    _rtLogger.logError(
      'Test error log message',
      stackTrace: StackTrace.fromString(
        'Test error log stack trace data!',
      ),
    );

    setState(() {});
  }

  void _addTestMessageLog() {
    _rtLogger.logMessage(
      'Test error log message',
    );

    setState(() {});
  }

  double _fontSize = 16;

  void changeFontSize(bool increase) => setState(
        () => increase ? _fontSize++ : _fontSize--,
      );

  Future<void> _copyLog(
    String logText,
  ) async =>
      await Clipboard.setData(
        ClipboardData(
          text: logText,
        ),
      );

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: context.pop,
            icon: Icon(
              Icons.arrow_back,
              color: context.color.primary,
            ),
          ),
          title: Text(
            'Logs',
            textAlign: TextAlign.center,
            style: context.text.headline3Bold,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Font size',
                        style: context.text.headline5SemiBold,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () => changeFontSize(false),
                        icon: const Icon(
                          Icons.remove_circle,
                        ),
                      ),
                      Text(
                        '$_fontSize',
                        style: context.text.headline5SemiBold,
                      ),
                      IconButton(
                        onPressed: () => changeFontSize(true),
                        icon: const Icon(
                          Icons.add_circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: context.color.alert,
                        onPressed: _addTestErrorLog,
                        child: Text(
                          'Test Error log',
                          style: context.text.headline5SemiBold.copyWith(
                            color: context.color.buttonTitle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: context.color.activeDeep,
                        onPressed: _addTestMessageLog,
                        child: Text(
                          'Test Message log',
                          style: context.text.headline5SemiBold.copyWith(
                            color: context.color.buttonTitle,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  itemCount: AppLoggerHistory.instance.logs.length,
                  itemBuilder: (context, index) {
                    final log = AppLoggerHistory.instance.logs[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(
                          color: log is HistoryErrorLog
                              ? context.color.alert
                              : context.color.activeDeep,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectableText(
                              log.logString,
                              style: context.text.headline5SemiBold.copyWith(
                                fontSize: _fontSize,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            onPressed: () => _copyLog(
                              log.logString,
                            ),
                            child: Text(
                              'Скопировать',
                              style: context.text.headline6SemiBold,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (
                    context,
                    index,
                  ) =>
                      const SizedBox(
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
