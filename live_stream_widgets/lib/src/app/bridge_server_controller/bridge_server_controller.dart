import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:live_stream_widgets/src/app/models/stream_widgets_models/stream_widget_client_model/stream_widget_client_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/stream_widget_message_model/stream_widget_message_model.dart';

part 'bridge_server_state.dart';

class BridgeServerController extends Cubit<BridgeServerState> {
  final FlutterSecureStorage _secureStorage;

  WebSocketChannel? _wsChannel;

  BridgeServerController(
    this._secureStorage,
  ) : super(
          const BridgeServerInitialState(),
        );

  Future<void> _listenWSConnection() async {
    if (state.bridgeServerUrl is! String) return;

    try {
      final wsUrl = Uri.parse(
        state.bridgeServerUrl!,
      );

      _wsChannel = WebSocketChannel.connect(wsUrl);

      await _wsChannel?.ready;

      if (state.clientModel is! StreamWidgetClientModel) {
        debugPrint('Client model is null');

        return;
      }

      final message = StreamWidgetMessageModel(
        clientData: state.clientModel!,
      );

      _wsChannel?.sink.add(
        message.toJson(),
      );

      _wsChannel?.stream.listen(
        (message) => emit(
          state.copyWith(
            receivedMessage: '$message',
          ),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to listen WS connection: $error\nstackTrace:$stackTrace',
      );
    }
  }

  Future<void> _getBridgeUrlFromSecureStorage() async {
    if (state.errorMessage is String) {
      emit(
        state.clearErrorMessage(),
      );
    }

    try {
      final bridgeUrl = await _secureStorage.read(
        key: 'bridgeUrl',
      );

      if (bridgeUrl == null) {
        throw Exception('Cannot find bridge url inside local storage');
      }

      emit(
        state.copyWith(
          bridgeServerUrl: bridgeUrl,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to get bridge url: $error\nstackTrace:$stackTrace',
      );
    }
  }

  Future<void> setBridgeServerUriAndClientData(
    String url,
    StreamWidgetClientModel clientModel,
  ) async {
    if (state.errorMessage is String) {
      emit(
        state.clearErrorMessage(),
      );
    }

    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      if (url.startsWith('http://') ||
          url.startsWith('https://') ||
          url.startsWith('ws://')) {
        // await _secureStorage.write(
        //   key: 'bridgeUrl',
        //   value: url,
        // );

        emit(
          state.copyWith(
            bridgeServerUrl: url,
            clientModel: clientModel,
          ),
        );

        await _listenWSConnection();
      } else {
        emit(
          BridgeServerState(
            errorMessage: 'Url must starts from http:// or https:// or ws://',
          ),
        );
      }
    } catch (error, stackTrace) {
      debugPrint(
        'Failed to set bridge url: $error\nstackTrace:$stackTrace',
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    print('close');
    return super.close();
  }
}
