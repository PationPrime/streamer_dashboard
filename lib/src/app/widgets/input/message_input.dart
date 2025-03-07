import 'package:flutter/cupertino.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../buttons/buttons.dart';

class MessageInput extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  const MessageInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmit,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  late final FocusNode _focusNode;

  void _update(VoidCallback fn) {
    if (!mounted) return;

    setState(fn);
  }

  void _focusListner() => _update(() {});

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_focusListner);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListner);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: CupertinoTextField(
          focusNode: _focusNode,
          suffix: SendButton(
            enabled: widget.controller.value.text.isNotEmpty,
            onTap: widget.controller.value.text.isEmpty
                ? null
                : () => widget.onSubmit?.call(
                      widget.controller.value.text,
                    ),
          ),
          onSubmitted: widget.controller.value.text.isEmpty
              ? null
              : (text) {
                  widget.onSubmit?.call(text);

                  _focusNode.requestFocus();
                },
          onChanged: widget.onChanged,
          controller: widget.controller,
          style: context.text.headline4Regular,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.color.secondary,
            border: Border.all(
              color: _focusNode.hasFocus
                  ? context.color.border
                  : context.color.lightBorder,
            ),
          ),
        ),
      );
}
