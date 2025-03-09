part of 'stream_widgets_controller.dart';

class StreamWidgetsState extends Equatable {
  final bool isProcessing;
  final Uri? hostingUri;

  const StreamWidgetsState({
    this.isProcessing = false,
    this.hostingUri,
  });

  @override
  List<Object?> get props => [
        isProcessing,
        hostingUri,
      ];

  StreamWidgetsState copyWith({
    bool? isProcessing,
    Uri? hostingUri,
  }) =>
      StreamWidgetsState(
        isProcessing: isProcessing ?? this.isProcessing,
        hostingUri: hostingUri ?? this.hostingUri,
      );
}

final class StreamWidgetsInitialState extends StreamWidgetsState {
  const StreamWidgetsInitialState();
}
