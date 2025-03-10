part of 'stream_widgets_controller.dart';

class StreamWidgetsState extends Equatable {
  final bool isProcessing;
  final Uri? webAppHostingUri;
  final Uri? bridgeServerHostingUri;
  final Failure? failure;

  const StreamWidgetsState({
    this.isProcessing = false,
    this.webAppHostingUri,
    this.bridgeServerHostingUri,
    this.failure,
  });

  @override
  List<Object?> get props => [
        isProcessing,
        webAppHostingUri,
        bridgeServerHostingUri,
        failure,
      ];

  StreamWidgetsState copyWith({
    bool? isProcessing,
    Uri? webAppHostingUri,
    Uri? bridgeServerHostingUri,
    Failure? failure,
  }) =>
      StreamWidgetsState(
        isProcessing: isProcessing ?? this.isProcessing,
        webAppHostingUri: webAppHostingUri ?? this.webAppHostingUri,
        bridgeServerHostingUri:
            bridgeServerHostingUri ?? this.bridgeServerHostingUri,
        failure: failure ?? this.failure,
      );

  StreamWidgetsState clearFailure() => StreamWidgetsState(
        bridgeServerHostingUri: bridgeServerHostingUri,
        isProcessing: isProcessing,
        webAppHostingUri: webAppHostingUri,
      );
}

final class StreamWidgetsInitialState extends StreamWidgetsState {
  const StreamWidgetsInitialState();
}
