part of 'bridge_server_controller.dart';

class BridgeServerState extends Equatable {
  final String? bridgeServerUrl;
  final bool loading;
  final String? errorMessage;
  final String? receivedMessage;

  const BridgeServerState({
    this.bridgeServerUrl,
    this.loading = false,
    this.errorMessage,
    this.receivedMessage,
  });

  @override
  List<Object?> get props => [
        bridgeServerUrl,
        loading,
        errorMessage,
        receivedMessage,
      ];

  BridgeServerState copyWith({
    String? bridgeServerUrl,
    bool? loading,
    String? errorMessage,
    String? receivedMessage,
  }) =>
      BridgeServerState(
        bridgeServerUrl: bridgeServerUrl ?? this.bridgeServerUrl,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        receivedMessage: receivedMessage ?? this.receivedMessage,
      );

  BridgeServerState clearErrorMessage() => BridgeServerState(
        bridgeServerUrl: bridgeServerUrl,
        loading: loading,
        receivedMessage: receivedMessage,
      );
}

final class BridgeServerInitialState extends BridgeServerState {
  const BridgeServerInitialState();
}
