import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class RadioButtonRow extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onChanged;
  final String? text;
  final RichText? richText;

  const RadioButtonRow({
    super.key,
    this.text,
    required this.onChanged,
    required this.isSelected,
    this.richText,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged(!isSelected),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? context.color.primary
                        : context.color.disabled,
                    width: isSelected ? 1.25 : 1,
                  ),
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 100,
                    ),
                    child: CircleAvatar(
                      backgroundColor:
                          isSelected ? context.color.primary : Colors.white,
                      radius: 7.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (text != null || richText != null)
                Expanded(
                  child: text != null
                      ? Text(
                          text!,
                        )
                      : richText!,
                ),
            ],
          ),
        ),
      );
}
