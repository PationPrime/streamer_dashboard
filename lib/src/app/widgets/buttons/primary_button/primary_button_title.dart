// ignore_for_file: unused_element

part of 'primary.dart';

class _PrimaryButtonTitle extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? icon;
  final Color? titleColor;
  final int? counter;
  final bool? fontWeight500;

  const _PrimaryButtonTitle({
    super.key,
    this.title,
    this.titleStyle,
    this.icon,
    this.titleColor,
    this.counter,
    this.fontWeight500,
  });

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: '',
          children: [
            if (icon != null)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 10),
                  child: icon!,
                ),
              ),
            TextSpan(
              text: title!,
              style: context.text.headline5Medium.copyWith(
                height: 0,
                color: titleColor ?? context.color.buttonTitle,
              ),
            ),
            if (counter != null)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: context.color.active,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  child: Text(
                    '$counter',
                  ),
                ),
              ),
          ],
        ),
        style: titleStyle,
      );
}
