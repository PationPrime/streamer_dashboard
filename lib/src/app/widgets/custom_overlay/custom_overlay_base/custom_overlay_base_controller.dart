part of 'custom_overlay_base.dart';

class CustomOverlayBaseController<S extends CustomOverlayBaseState> {
  S? state;

  final _stateStreamController = StreamController<bool>();

  Stream<bool> get _stateStream => _stateStreamController.stream;

  Sink<bool> get _stateSink => _stateStreamController.sink;

  bool shown = false;

  void setupController(
    S overlayDialogWrapperState,
  ) =>
      state = overlayDialogWrapperState;

  Future<void> show({
    VoidCallback? callBack,
  }) async {
    if (state is! S) {
      return;
    }

    await state!._show(callBack: callBack);

    _stateSink.add(true);

    shown = true;
  }

  bool? onCursorOnOverlay(PointerExitEvent event) =>
      state?.onCursorOnOverlay(event);

  Future<void> hide({
    VoidCallback? callBack,
  }) async {
    shown = false;

    if (state is! S) {
      return;
    }

    await state!._removeOverlayEntry(
      callBack: callBack,
    );

    _stateSink.add(false);
  }

  void toggle({
    VoidCallback? callBack,
  }) =>
      state?._overlayEntry is OverlayEntry
          ? hide(
              callBack: callBack,
            )
          : show(
              callBack: callBack,
            );

  void listenShownState(
    Function(bool) shown,
  ) =>
      _stateStream.listen(
        shown.call,
      );

  void clearState() => state = null;

  void dispose() {
    clearState();
    _stateStreamController.close();
  }
}
