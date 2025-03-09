part of 'custom_overlay_menu.dart';

class CustomOverlayMenuItem extends StatelessWidget {
  final CustomOverlayMenuItemData data;
  final void Function(CustomOverlayMenuItemData) onTap;
  final double? height;

  const CustomOverlayMenuItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.height,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: MaterialButton(
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
        ),
      );
}
