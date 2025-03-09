import 'package:flutter/cupertino.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../../assets_gen/assets.gen.dart';
import '../buttons/buttons.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Function(PointerDownEvent)? onTapOutside;
  final VoidCallback? onClearTap;

  const SearchInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.onTapOutside,
    this.onClearTap,
  });

  @override
  Widget build(BuildContext context) => CupertinoTextField(
        focusNode: focusNode,
        controller: controller,
        onTapOutside: onTapOutside,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SizedBox(
            width: 30,
            child: Center(
              child: Assets.icons.iconSearch.svg(
                color: (focusNode?.hasFocus ?? false)
                    ? context.color.primary
                    : context.color.lightBorder,
              ),
            ),
          ),
        ),
        suffix: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SizedBox(
            width: 30,
            height: 30,
            child: BouncyButtonWrapper(
              onTap: onClearTap,
              child: Center(
                child: Assets.icons.iconClose.svg(
                  color: (focusNode?.hasFocus ?? false)
                      ? context.color.primary
                      : context.color.lightBorder,
                ),
              ),
            ),
          ),
        ),
        style: context.text.headline5Regular,
        decoration: BoxDecoration(
          color: context.color.transparent,
          border: Border.all(
            color: (focusNode?.hasFocus ?? false)
                ? context.color.primary
                : context.color.lightBorder,
          ),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
      );
}
