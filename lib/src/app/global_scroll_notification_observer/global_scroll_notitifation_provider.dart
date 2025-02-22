part of 'global_scroll_notification_observer.dart';

class GlobalScrollNotificationProvider extends InheritedWidget {
  final bool isAnythinScrolling;

  const GlobalScrollNotificationProvider({
    super.key,
    required super.child,
    this.isAnythinScrolling = false,
  });

  @override
  bool updateShouldNotify(
          covariant GlobalScrollNotificationProvider oldWidget) =>
      isAnythinScrolling != oldWidget.isAnythinScrolling;

  static GlobalScrollNotificationProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlobalScrollNotificationProvider>();
  }
}
