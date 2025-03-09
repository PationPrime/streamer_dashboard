part of 'custom_overlay_tabbar.dart';

class CustomOverlayTab extends StatelessWidget {
  final CustomOverlayTabbarItemData data;
  final void Function(CustomOverlayTabbarItemData) onTap;

  const CustomOverlayTab({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        mouseCursor: SystemMouseCursors.click,
        onPressed: () => onTap(data),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data.title,
            style: data.textStyle,
            textAlign: TextAlign.left,
          ),
        ),
      );
}
