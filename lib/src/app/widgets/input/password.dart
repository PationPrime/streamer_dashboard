import 'package:flutter/material.dart';

import 'input.dart';

class PasswordInput extends CommonInput {
  const PasswordInput({
    super.key,
    super.controller,
    super.obscureText = true,
    super.label,
    super.suffix,
    super.errorTexts,
    super.scrollPaddingToBottom,
    super.onChanged,
    super.showError,
    super.inputType,
    super.readOnly,
    super.textFormatters,
    super.textInputAction,
    super.autofillHints = const [
      AutofillHints.password,
    ],
    super.hintText,
    super.autofocus,
    super.onTap,
    super.focusNode,
    super.forceFocusOnTap,
  });
}
