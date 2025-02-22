import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/environment/environment.dart';
import '../router/navigator_key_provider.dart';

@immutable
class AppLogger {
  final String where;

  const AppLogger({
    required this.where,
  });

  void logError(
    String message, {
    String? code,
    String? lexicalScope,
    StackTrace? stackTrace,
    bool debugModeOnly = true,
    String? sign,
  }) {
    if (!kDebugMode && debugModeOnly) {
      return;
    }

    dev.log(
      '${sign ?? "😡"} ($where)${lexicalScope is String ? "\n⚡ lexical scope: $lexicalScope" : ""}${code is String ? "\n💢 code: [$code]" : ""}\n💬 message: [$message]${stackTrace is StackTrace ? "\n\n🤯 stackTrace: $stackTrace 🥺" : ""}',
    );
  }

  void logMessage(
    String message, {
    String? lexicalScope,
    bool showWhere = true,
    bool debugModeOnly = true,
    bool showDedails = false,
    String? sign,
  }) {
    if (!kDebugMode && debugModeOnly) {
      return;
    }

    dev.log(
      "${sign ?? "💬"} ${showWhere ? (where) : ''}${lexicalScope is String ? " (lexical scope: $lexicalScope)" : ""}: $message",
    );
  }

  void showMessageBar(
    String message, {
    StackTrace? stackTrace,
    String? logName,
  }) {
    if (AppEnvironment.instance.mainIsProd) return;

    final rootContext = NavigatorKeyProvider.instance.currentContext;

    if (rootContext is! BuildContext) {
      return;
    }

    try {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                logName ?? "new log",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  MaterialButton(
                    color: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () =>
                        ScaffoldMessenger.of(rootContext).hideCurrentSnackBar(),
                    child: const Text(
                      "close",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () => Navigator.push(
                      rootContext,
                      MaterialPageRoute(
                        builder: (_) => _LoggerDetails(
                          message: message,
                          stackTrace: stackTrace,
                        ),
                      ),
                    ),
                    child: const Text(
                      "show",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      ///
    }
  }

  void logArgsList(
    Map<String, dynamic> args, [
    bool debugModeOnly = true,
  ]) {
    if (!kDebugMode && debugModeOnly) {
      return;
    }

    for (int i = 0; i < args.length; i++) {
      logMessage(
        'argument [ ${args.keys.toList()[i]} ] : ${args.values.toList()[i]}',
        showWhere: false,
      );
      if (args.keys.toList()[i] == args.keys.last) {
        logMessage(
          '-----------------------------------------------------------------------\n',
          showWhere: false,
        );
      }
    }
  }
}

class _LoggerDetails extends StatelessWidget {
  final String? message;
  final StackTrace? stackTrace;

  const _LoggerDetails({
    this.message,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Log details",
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            children: [
              Text(
                "errorMessage: ${message ?? "unknown message"}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              if (stackTrace is StackTrace)
                Text(
                  "stackTrace: $stackTrace",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      );
}
