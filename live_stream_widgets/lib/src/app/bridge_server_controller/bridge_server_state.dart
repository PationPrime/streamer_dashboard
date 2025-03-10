part of 'bridge_server_controller.dart';

class BridgeServerState extends Equatable {
  final String? bridgeServerUrl;
  final bool loading;
  final String? errorMessage;

  const BridgeServerState({
    this.bridgeServerUrl,
    this.loading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        bridgeServerUrl,
        loading,
        errorMessage,
      ];

  BridgeServerState copyWith({
    String? bridgeServerUrl,
    bool? loading,
    String? errorMessage,
  }) =>
      BridgeServerState(
        bridgeServerUrl: bridgeServerUrl ?? this.bridgeServerUrl,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  BridgeServerState clearErrorMessage() => BridgeServerState(
        bridgeServerUrl: bridgeServerUrl,
        loading: loading,
      );
}

final class BridgeServerInitialState extends BridgeServerState {
  const BridgeServerInitialState();
}
