import 'package:flutter/widgets.dart';

part 'global_scroll_notitifation_provider.dart';

class GlobalScrollNotificationObserver extends StatefulWidget {
  final Widget child;

  const GlobalScrollNotificationObserver({
    super.key,
    required this.child,
  });

  @override
  State<GlobalScrollNotificationObserver> createState() =>
      _GlobalScrollNotificationObserverState();
}

class _GlobalScrollNotificationObserverState
    extends State<GlobalScrollNotificationObserver> {
  bool _isScrolling = false;

  void _update(VoidCallback fn) {
    if (!mounted) return;

    setState(fn);
  }

  void _updateScrolling(bool value) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _update(
        () => _isScrolling = value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            if (notification is ScrollStartNotification ||
                notification is ScrollUpdateNotification) {
              _updateScrolling(true);
            } else if (notification is ScrollEndNotification) {
              _updateScrolling(false);
            }
          }
          return false;
        },
        child: GlobalScrollNotificationProvider(
          isAnythinScrolling: _isScrolling,
          child: widget.child,
        ),
      );
}
