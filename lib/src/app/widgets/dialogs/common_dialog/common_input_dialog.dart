import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';

import '../../../../assets_gen/assets.gen.dart';
import '../../buttons/buttons.dart';
import '../../input/input.dart';

class CommonDialog extends StatefulWidget {
  final String title;
  final String? description;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final String? saveButtonText;
  final String? closeButtonText;
  final String? initialText;

  const CommonDialog({
    super.key,
    required this.title,
    this.description,
    this.onCancel,
    this.onSubmit,
    this.saveButtonText,
    this.closeButtonText,
    this.initialText,
  });

  @override
  State<CommonDialog> createState() => _CommonDialogState();

  static Future<String?> show({
    required BuildContext context,
    required String title,
    required String description,
    String? saveButtonText,
    String? closeButtonText,
    VoidCallback? onSubmit,
    VoidCallback? onCancel,
    String? initialText,
  }) async =>
      showDialog<String?>(
        context: context,
        builder: (context) => CommonDialog(
          title: title,
          saveButtonText: saveButtonText,
          closeButtonText: closeButtonText,
          description: description,
          onCancel: onCancel,
          onSubmit: onSubmit,
          initialText: initialText,
        ),
      );
}

class _CommonDialogState extends State<CommonDialog> {
  late final TextEditingController _controller;
  bool _obscureText = true;

  bool get _showClearButton => _controller.value.text.isNotEmpty;

  void _onClearButtonPressed() {
    _controller.clear();
  }

  void _toggleObscureText() => setState(
        () => _obscureText = !_obscureText,
      );

  void _inputListener() {
    setState(() {});
  }

  void _init() {
    _controller = TextEditingController(
      text: widget.initialText,
    );

    _controller.addListener(_inputListener);
  }

  void _dispose() {
    _controller.removeListener(_inputListener);
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 500,
            minHeight: 100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.description is String)
                Text(
                  widget.description!,
                ),
              CommonInput(
                obscureText: _obscureText,
                controller: _controller,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButton(
                      backgroundColor: context.color.transparent,
                      onTap: _toggleObscureText,
                      icon: _obscureText
                          ? Assets.icons.iconHidePassword.svg(
                              color: context.color.primary,
                            )
                          : Assets.icons.iconShowPassword.svg(
                              color: context.color.primary,
                            ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    _showClearButton
                        ? RoundedButton(
                            backgroundColor: context.color.transparent,
                            onTap: _onClearButtonPressed,
                            icon: Assets.icons.closeCross.svg(
                              color: context.color.primary,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.onCancel?.call();
              Navigator.of(context).pop();
            },
            child: Text(
              widget.closeButtonText ??
                  LocaleKeys.common_input_dialog_buttons_close_title.tr(),
              style: context.text.headline4Medium.copyWith(
                color: context.color.cancel,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.onSubmit?.call();
              Navigator.of(context).pop(_controller.text);
            },
            child: Text(
              widget.saveButtonText ??
                  LocaleKeys.common_input_dialog_buttons_save_title.tr(),
              style: context.text.headline4Medium.copyWith(
                color: context.color.active,
              ),
            ),
          ),
        ],
      );
}
