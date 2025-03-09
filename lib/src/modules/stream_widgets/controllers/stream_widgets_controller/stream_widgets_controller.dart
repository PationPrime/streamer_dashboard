import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

import '../../../../app/tools/tools.dart';

part 'stream_widgets_state.dart';

class StreamWidgetsController extends Cubit<StreamWidgetsState> {
  late final _appLogger = AppLogger(where: '$this');

  HttpServer? _server;

  static const _host = 'localhost';

  int _port = 5550;

  int _connectionAttempts = 0;

  StreamWidgetsController()
      : super(
          const StreamWidgetsInitialState(),
        ) {
    _startWidgetsHosting(
      stopBeforeStart: false,
    );
  }

  Future<bool> _isPortAvailable() async {
    if (_connectionAttempts >= 20) return false;

    try {
      final server = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        _port,
      );

      await server.close();

      return true;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Exception: port $_port is not available. Retrying...',
        stackTrace: stackTrace,
        sign: '👾',
      );

      _connectionAttempts++;
      _port++;

      return await _isPortAvailable();
    }
  }

  Future<void> _startWidgetsHosting({
    bool stopBeforeStart = true,
  }) async {
    emit(
      state.copyWith(
        isProcessing: true,
      ),
    );

    try {
      if (stopBeforeStart) {
        await stopWidgetsHosting();
      }

      final isAvailable = await _isPortAvailable();

      if (!isAvailable) {
        throw Exception(
          'Exception: port $_port is not available!',
        );
      }

      final handler = createStaticHandler(
        'webview_widgets\\build\\web',
        defaultDocument: 'index.html',
      );

      _server = await shelf_io.serve(
        handler,
        _host,
        _port,
      );

      if (_server == null) {
        throw Exception('Failed to start hosting. Server is null!');
      }

      emit(
        state.copyWith(
          hostingUri: Uri.parse(
            'http://${_server!.address.host}:${_server!.port}',
          ),
        ),
      );

      ///
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Start hosting server failed! $error',
        stackTrace: stackTrace,
      );
    } finally {
      emit(
        state.copyWith(
          isProcessing: false,
        ),
      );
    }
  }

  Future<void> stopWidgetsHosting() async {
    try {
      if (_server == null) {
        throw Exception(
          'Failed to stop widgets hosting! Server is null!',
        );
      }

      await _server!.close();

      _appLogger.logMessage('Server stopped.');

      _server = null;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to stop widgets hosting! $error',
        stackTrace: stackTrace,
      );
    }
  }
}
