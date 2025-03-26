import 'dart:developer' as dev;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/environment/environment.dart';
import '../router/navigator_key_provider.dart';

class HistoryErrorLog extends HistoryLog {
  final String? code;
  final StackTrace? stackTrace;

  HistoryErrorLog({
    this.code,
    this.stackTrace,
    required super.message,
    required super.showWhere,
    super.debugModeOnly = true,
    super.lexicalScope,
    super.sign,
    super.where,
  });

  @override
  String get logString =>
      '${sign ?? "😡"} ${showWhere ? (where) : ''}${lexicalScope is String ? "\n⚡ lexical scope: $lexicalScope" : ""}${code is String ? "\n💢 code: [$code]" : ""}\n💬 message: [$message]${stackTrace is StackTrace ? "\n\n🤯 stackTrace: $stackTrace 🥺" : ""}';
}

class HistoryMessageLog extends HistoryLog {
  final bool showDedails;

  HistoryMessageLog({
    required super.message,
    required super.showWhere,
    super.debugModeOnly = true,
    this.showDedails = false,
    super.lexicalScope,
    super.sign,
    super.where,
  });

  @override
  String get logString =>
      "${sign ?? "💬"} ${showWhere ? (where) : ''}${lexicalScope is String ? " (lexical scope: $lexicalScope)" : ""}: $message";
}

sealed class HistoryLog with EquatableMixin {
  final String message;
  final String? lexicalScope;
  final bool showWhere;
  final bool debugModeOnly;
  final String? sign;
  final String? where;

  String get logString;

  const HistoryLog({
    required this.message,
    required this.showWhere,
    required this.debugModeOnly,
    this.sign,
    this.lexicalScope,
    this.where,
  });

  @override
  List<Object?> get props => [
        message,
        showWhere,
        debugModeOnly,
        sign,
        lexicalScope,
        where,
      ];
}

final class AppLoggerHistory {
  AppLoggerHistory._();

  static final instance = AppLoggerHistory._();

  final List<HistoryLog> _logs = [];

  List<HistoryLog> get logs => _logs;

  void addLog(
    HistoryLog log, {
    String? where,
  }) {
    _logs.add(log);
  }

  void removeLog(HistoryLog log) {
    _logs.remove(log);
  }
}

@immutable
class AppLogger {
  static final _loggerHistory = AppLoggerHistory.instance;

  final String where;

  const AppLogger({
    required this.where,
  });

  void logError(
    String message, {
    String? code,
    bool showWhere = true,
    String? lexicalScope,
    StackTrace? stackTrace,
    bool debugModeOnly = true,
    String? sign,
  }) {
    if (!AppEnvironment.instance.isDev && !kDebugMode && debugModeOnly ||
        AppEnvironment.instance.isProd) {
      return;
    }

    dev.log(
      '${sign ?? "😡"} ${showWhere ? (where) : ''}${lexicalScope is String ? "\n⚡ lexical scope: $lexicalScope" : ""}${code is String ? "\n💢 code: [$code]" : ""}\n💬 message: [$message]${stackTrace is StackTrace ? "\n\n🤯 stackTrace: $stackTrace 🥺" : ""}',
    );

    _loggerHistory.addLog(
      HistoryErrorLog(
        message: message,
        lexicalScope: lexicalScope,
        showWhere: showWhere,
        debugModeOnly: debugModeOnly,
        stackTrace: stackTrace,
        code: code,
        sign: sign,
        where: where,
      ),
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
    if (!AppEnvironment.instance.isDev && !kDebugMode && debugModeOnly ||
        AppEnvironment.instance.isProd) {
      return;
    }

    dev.log(
      "${sign ?? "💬"} ${showWhere ? (where) : ''}${lexicalScope is String ? " (lexical scope: $lexicalScope)" : ""}: $message",
    );

    _loggerHistory.addLog(
      HistoryMessageLog(
        message: message,
        lexicalScope: lexicalScope,
        showWhere: showWhere,
        debugModeOnly: debugModeOnly,
        showDedails: showDedails,
        sign: sign,
        where: where,
      ),
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
    if (!AppEnvironment.instance.isDev && !kDebugMode && debugModeOnly ||
        AppEnvironment.instance.isProd) {
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
