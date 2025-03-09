part of 'custom_overlay_tabbar.dart';

class CustomOverlayTabbarItemData extends Equatable {
  final String title;
  final TextStyle textStyle;
  final String url;
  final String deepLinkPath;
  final bool useNativePath;

  const CustomOverlayTabbarItemData({
    required this.title,
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
    this.url = '',
    this.deepLinkPath = '',
    this.useNativePath = false,
  });

  @override
  List<Object?> get props => [
        title,
        textStyle,
        url,
        deepLinkPath,
        useNativePath,
      ];
}
