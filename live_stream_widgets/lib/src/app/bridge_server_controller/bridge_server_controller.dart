import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'bridge_server_state.dart';

class BridgeServerController extends Cubit<BridgeServerState> {
  final FlutterSecureStorage _secureStorage;

  BridgeServerController(
    this._secureStorage,
  ) : super(
          const BridgeServerInitialState(),
        ) {
    // _getBridgeUrlFromSecureStorage();
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

  Future<void> setBridgeServerUri(String url) async {
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
        await _secureStorage.write(
          key: 'bridgeUrl',
          value: url,
        );

        emit(
          state.copyWith(
            bridgeServerUrl: url,
          ),
        );
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
