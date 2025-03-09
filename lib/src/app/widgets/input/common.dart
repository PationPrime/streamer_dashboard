import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

class CommonInput extends StatefulWidget {
  final bool? enabled;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? label;
  final String? obscuringCharacter;
  final List<String> errorTexts;
  final Widget? suffix;
  final TextInputType? inputType;
  final double? scrollPaddingToBottom;
  final bool showError;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter> textFormatters;
  final TextInputAction textInputAction;
  final TextStyle? hintTextStyle;
  final Iterable<String>? autofillHints;
  final String? initialText;
  final bool useTooltip;
  final bool toolTipCondition;
  final String? toolTipText;
  final Color? textColor;
  final String? hintText;
  final bool autofocus;
  final bool forceFocusOnTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? labelPadding;

  const CommonInput({
    super.key,
    this.controller,
    this.obscureText,
    this.obscuringCharacter,
    this.label,
    this.errorTexts = const [],
    this.suffix,
    this.inputType,
    this.scrollPaddingToBottom,
    this.showError = false,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.autofillHints,
    this.readOnly = false,
    this.textFormatters = const [],
    this.textInputAction = TextInputAction.next,
    this.hintTextStyle,
    this.initialText,
    this.useTooltip = false,
    this.toolTipCondition = false,
    this.toolTipText,
    this.textColor,
    this.hintText,
    this.enabled,
    this.autofocus = false,
    this.forceFocusOnTap = false,
    this.focusNode,
    this.prefixIcon,
    this.labelPadding,
  });

  @override
  State<CommonInput> createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  FocusNode _focusNode = FocusNode();

  void _focusListener() => _focusNode.addListener(
        () => setState(() {}),
      );

  String _generateErrorText() {
    String errorText = "";
    if (widget.errorTexts.isNotEmpty) {
      for (String text in widget.errorTexts) {
        errorText += text == widget.errorTexts.first ? "• $text" : "\n• $text";
      }
    }

    return errorText;
  }

  @override
  void didChangeDependencies() {
    _generateErrorText();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _generateErrorText();
    _focusListener();

    _focusNode = widget.focusNode ?? _focusNode;
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: _focusNode.hasFocus
                    ? context.color.background
                    : context.color.defaultInput,
              ),
              alignment: Alignment.bottomCenter,
              child: Material(
                color: context.color.transparent,
                child: TextFormField(
                  autofocus: widget.autofocus,
                  focusNode: _focusNode,
                  enabled: widget.enabled ?? true,
                  onEditingComplete: widget.onEditingComplete,
                  onTap: widget.onTap,
                  textInputAction: widget.textInputAction,
                  autofillHints: widget.autofillHints,
                  readOnly: widget.readOnly,
                  onChanged: widget.onChanged,
                  keyboardType: widget.inputType,
                  cursorColor: context.color.inputCursor,
                  controller:
                      widget.initialText is String ? null : widget.controller,
                  cursorWidth: 1,
                  autocorrect: false,
                  cursorHeight: kIsWeb
                      ? 15
                      : Platform.isMacOS
                          ? 20
                          : Platform.isIOS
                              ? 15
                              : null,
                  initialValue: widget.initialText,
                  inputFormatters: widget.textFormatters,
                  obscureText: widget.obscureText ?? false,
                  obscuringCharacter: widget.obscuringCharacter ?? '•',
                  scrollPadding: EdgeInsets.only(
                    bottom: widget.scrollPaddingToBottom is double
                        ? widget.scrollPaddingToBottom!
                        : 0.0,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: context.text.headline3Regular.copyWith(
                    fontSize: widget.obscureText is bool && widget.obscureText!
                        ? 50
                        : null,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    hintText: widget.hintText,
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      top: 10,
                    ),
                    label: widget.label is String
                        ? Padding(
                            padding: widget.labelPadding ?? EdgeInsets.zero,
                            child: Text(
                              widget.label!,
                            ),
                          )
                        : null,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.showError
                            ? context.color.alert
                            : context.color.active,
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.showError
                            ? context.color.alert
                            : !_focusNode.hasFocus
                                ? context.color.border
                                : context.color.active,
                        width: _focusNode.hasFocus ? 2 : 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.suffix is Widget)
              Positioned(
                right: 11,
                top: 0.0,
                bottom: 0.0,
                child: Container(
                  color: context.color.transparent,
                  child: widget.suffix,
                ),
              )
          ],
        ),
        if (widget.showError && _generateErrorText().isNotEmpty)
          const SizedBox(height: 10),
        if (widget.showError && _generateErrorText().isNotEmpty)
          Text(
            _generateErrorText(),
            style: TextStyle(
              height: 19.2 / 16,
              fontSize: 14,
              color: context.color.alert,
            ),
          )
      ],
    );
  }
}
