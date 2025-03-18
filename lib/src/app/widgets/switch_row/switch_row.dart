import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';

class SwitchRow extends StatelessWidget {
  final String title;
  final String? switchTitle;
  final bool value;
  final void Function(bool)? onChanged;

  const SwitchRow({
    super.key,
    required this.value,
    required this.title,
    this.switchTitle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            title,
            style: context.text.headline4Regular,
          ),
          const SizedBox(
            width: 10,
          ),
          const Spacer(),
          if (switchTitle is String)
            Text(
              switchTitle!,
              style: context.text.headline4Regular,
            ),
          const SizedBox(
            width: 10,
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: context.color.activeDeep,
            activeTrackColor: context.color.active,
            inactiveTrackColor: context.color.background,
            inactiveThumbColor: context.color.lightBorder.withAlpha(
              125,
            ),
            trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
              (states) {
                if (!states.contains(WidgetState.selected)) {
                  return 1;
                }

                return null;
              },
            ),
            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
                if (!states.contains(WidgetState.selected)) {
                  return context.color.lightBorder.withAlpha(
                    50,
                  );
                }

                return null;
              },
            ),
          ),
        ],
      );
}
