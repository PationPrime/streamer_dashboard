import 'dart:convert';
import 'dart:math' as math;

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/errors/app_error_handler/app_error_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../app/dto/stream_widgets_dto/stream_widget_client_response_dto/stream_widget_client_response_dto.dart';
import '../../../../app/failure/failure.dart';
import '../../../../app/models/models.dart';
import '../../../../app/tools/tools.dart';

part 'stream_widgets_state.dart';

class StreamWidgetsController extends Cubit<StreamWidgetsState> {
  late final _appLogger = AppLogger(where: '$this');

  final List<StreamWidgetClient> clients = [];
  static const _webAppRelativePath = 'live_stream_widgets\\build\\web';
  static const _defualtWebDocument = 'index.html';
  static const _faviconFile = 'favicon.ico';
  static const _faviconPath = '$_webAppRelativePath\\$_faviconFile';
  static const _webAppHost = NetworkConstants.localhost;
  static const _bridgeServerHost = NetworkConstants.localhost;
  static const _errorHandler = AppErrorHandler();

  HttpServer? _webAppHostingServer;
  int _connectionAttempts = 0;

  StreamWidgetsController()
      : super(
          const StreamWidgetsInitialState(),
        ) {
    _init();
  }

  Future<int?> _isPortAvailable(int port) async {
    if (_connectionAttempts >= 20) return null;

    try {
      final server = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        port,
      );

      await server.close();

      return port;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Exception: port $port is not available. Retrying...',
        stackTrace: stackTrace,
        sign: '👾',
      );

      _connectionAttempts++;
      port++;

      return await _isPortAvailable(
        port,
      );
    }
  }

  Future<void> _startWidgetsHosting({
    bool stopBeforeStart = true,
  }) async {
    try {
      if (stopBeforeStart) {
        await _stopWidgetsHosting();
      }

      final port = math.Random().nextInt(800) + 10000;

      final availablePort = await _isPortAvailable(
        port,
      );

      if (availablePort is! int) {
        throw Exception(
          'Exception: Failed to find free hosting port',
        );
      }
      final staticHandler = createStaticHandler(
        _webAppRelativePath,
        defaultDocument: _defualtWebDocument,
        serveFilesOutsidePath: true,
      );

      handler(Request request) async {
        final path = request.url.path;
        final filePath = '$_webAppRelativePath\\$path';

        if (path == _faviconFile) {
          if (await File(_faviconPath).exists()) {
            return staticHandler(
              request,
            );
          } else {
            return Response.notFound('favicon.ico not found');
          }
        }

        if (await File(filePath).exists()) {
          return staticHandler(request);
        }

        final uri = Uri.parse(
          'http://$_webAppHost:$port/$_defualtWebDocument',
        );

        return staticHandler(Request('GET', uri));
      }

      _webAppHostingServer = await shelf_io.serve(
        handler,
        _webAppHost,
        port,
      );

      if (_webAppHostingServer == null) {
        throw Exception('Failed to start hosting. Server is null!');
      }

      final webAppHostingUri = Uri.parse(
        'http://${_webAppHostingServer!.address.host}:${_webAppHostingServer!.port}?bridgeUrl=${state.bridgeServerHostingUri}',
      );

      emit(
        state.copyWith(
          webAppHostingUri: webAppHostingUri,
        ),
      );

      _appLogger.logMessage(
        'Stream Widgets starts at $webAppHostingUri',
      );

      ///
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Start hosting server failed! $error',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _stopWidgetsHosting() async {
    try {
      if (_webAppHostingServer == null) {
        throw Exception(
          'Failed to stop widgets hosting! Server is null!',
        );
      }

      await _webAppHostingServer!.close();

      _appLogger.logMessage('Server stopped.');

      _webAppHostingServer = null;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to stop widgets hosting! $error',
        stackTrace: stackTrace,
      );
    }
  }

  void _broadcastBridgeServerMessage({
    required String message,
    required StreamWidgetClient sender,
  }) {
    for (final client in clients) {
      if (client != sender) {
        client.channel?.sink.add(message);
      }
    }
  }

  Future<void> _startBridgeServer() async {
    try {
      final port = math.Random().nextInt(800) + 11000;
      final availablePort = await _isPortAvailable(port);

      if (availablePort is! int) {
        throw Exception(
          'Exception: Failed to find free hosting port',
        );
      }

      final handler = webSocketHandler(
        (WebSocketChannel webSocket, String? _) {
          _appLogger.logMessage(
            'New connection',
          );

          webSocket.stream.listen(
            (message) {
              if (message is String) {
                try {
                  final jsonData = jsonDecode(message);

                  final clientResponse = StreamWidgetClientResponseDto.fromJson(
                    jsonData,
                  );

                  final client = clientResponse.clientData.copyWith(
                    channel: webSocket,
                  );

                  _appLogger.logMessage(
                    'Message received: $client',
                  );

                  // Finally, add new client
                  clients.add(client);
                } catch (error, stackTrace) {
                  _appLogger.logError(
                    'Failed to add client: $error',
                    stackTrace: stackTrace,
                    lexicalScope: 'webSocket.stream.listen->onData',
                  );
                }
              }
            },
            onDone: () {
              try {
                clients.removeWhere(
                  (client) => client.channel == webSocket,
                );

                _appLogger.logMessage(
                  'Client disconnected',
                );
              } catch (error, stackTrace) {
                _appLogger.logError(
                  'Failed to remove client: $error',
                  stackTrace: stackTrace,
                  lexicalScope: 'webSocket.stream.listen->onDone',
                );
              }
            },
            onError: (error) {
              _appLogger.logMessage(
                'WebSocket error: $error',
              );

              try {
                clients.removeWhere(
                  (client) => client.channel == webSocket,
                );

                _appLogger.logMessage(
                  'Client removed',
                );
              } catch (error, stackTrace) {
                _appLogger.logError(
                  'Failed to remove client: $error',
                  stackTrace: stackTrace,
                  lexicalScope: 'webSocket.stream.listen->onError',
                );
              }
            },
          );
        },
      );

      final bridgeServer = await shelf_io.serve(
        handler,
        _bridgeServerHost,
        availablePort,
      );

      emit(
        state.copyWith(
          bridgeServerHostingUri: Uri.parse(
            'ws://${bridgeServer.address.host}:${bridgeServer.port}',
          ),
        ),
      );

      _appLogger.logMessage(
        'WebSocket starts at ${state.bridgeServerHostingUri}',
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to start bridge server: $error',
        stackTrace: stackTrace,
      );
    }
  }

  void sendMessageToAllClients() {
    print('clients count: ${clients.length}');

    for (final client in clients) {
      print(client.id);
    }

    // for (final client in clients) {
    //   client.channel?.sink.add(
    //     'Hello from the server!',
    //   );
    // }
    if (clients.isEmpty) return;

    sendMessageToClient(
      clients.firstWhere(
        // (client) => client.id == 'fb0e1259-f870-42c0-896d-84f42d3c9cca',
        // (client) => client.id == '306a5322-e821-45ac-9229-9f360c0879fa',
        (client) => client.id == '2c3878ee-6927-4ddc-846a-c35e2f4d1413',
      ),
    );
  }

  void sendMessageToClient(StreamWidgetClient client) {
    print('clients count: ${clients.length}');

    client.channel?.sink.add(
      '${client.id}, Hello OBS!',
    );
  }

  Future<void> _init() async {
    if (state.isProcessing) return;

    emit(
      state.copyWith(
        isProcessing: true,
      ),
    );

    try {
      await _startBridgeServer();
      await _startWidgetsHosting(
        stopBeforeStart: false,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to start bridge server: $error',
        stackTrace: stackTrace,
      );

      final failure = _errorHandler.handleError(
        error,
        stackTrace: stackTrace,
      );

      emit(
        state.copyWith(
          failure: failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          isProcessing: false,
        ),
      );
    }
  }

  Future<void> retryInit() async {
    if (state.failure is Failure) {
      emit(
        state.clearFailure(),
      );
    }

    await _init();
  }

  Future<void> shutdownServer() async {
    await _stopWidgetsHosting();
  }

  @override
  Future<void> close() {
    shutdownServer();
    return super.close();
  }
}
