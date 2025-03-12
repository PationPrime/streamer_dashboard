part of 'bridge_server_controller.dart';

class BridgeServerState extends Equatable {
  final String? bridgeServerUrl;
  final bool loading;
  final String? errorMessage;
  final String? receivedMessage;
  final StreamWidgetClientModel? clientModel;

  const BridgeServerState({
    this.bridgeServerUrl,
    this.loading = false,
    this.errorMessage,
    this.receivedMessage,
    this.clientModel,
  });

  @override
  List<Object?> get props => [
        bridgeServerUrl,
        loading,
        errorMessage,
        receivedMessage,
        clientModel,
      ];

  BridgeServerState copyWith({
    String? bridgeServerUrl,
    bool? loading,
    String? errorMessage,
    String? receivedMessage,
    StreamWidgetClientModel? clientModel,
  }) =>
      BridgeServerState(
        bridgeServerUrl: bridgeServerUrl ?? this.bridgeServerUrl,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        receivedMessage: receivedMessage ?? this.receivedMessage,
        clientModel: clientModel ?? this.clientModel,
      );

  BridgeServerState clearErrorMessage() => BridgeServerState(
        bridgeServerUrl: bridgeServerUrl,
        loading: loading,
        receivedMessage: receivedMessage,
        clientModel: clientModel,
      );
}

final class BridgeServerInitialState extends BridgeServerState {
  const BridgeServerInitialState();
}
