import 'package:flutter/material.dart';

import 'input.dart';

class EmailInput extends CommonInput {
  const EmailInput({
    super.key,
    super.controller,
    super.label,
    super.inputType,
    super.showError,
    super.errorTexts,
    super.scrollPaddingToBottom,
    super.onChanged,
    super.readOnly,
    super.textFormatters,
    super.textInputAction,
    super.autofillHints = const [
      AutofillHints.email,
    ],
    super.initialText,
    super.hintText,
    super.onTap,
    super.forceFocusOnTap,
    super.focusNode,
  });
}
