part of 'custom_overlay_menu.dart';

class CustomOverlayMenuItemData extends Equatable {
  final String title;
  final TextStyle textStyle;
  final Function() onClick;

  const CustomOverlayMenuItemData({
    required this.title,
    required this.onClick,
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
  });

  @override
  List<Object?> get props => [
        title,
        textStyle,
        onClick,
      ];
}
