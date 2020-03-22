import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/text_input_dialog/cupertino_text_input_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'material_text_input_dialog.dart';

Future<List<String>> showTextInputDialog({
  @required BuildContext context,
  @required List<DialogTextField> textFields,
  String titleLabel,
  String okLabel,
  String cancelLabel,
  String messageLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
}) {
  final theme = Theme.of(context);
  return style.isCupertinoStyle(theme)
      ? showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoTextInputDialog(
            textFields: textFields,
            titleLabel: titleLabel,
            okLabel: okLabel,
            cancelLabel: cancelLabel,
            messageLabel: messageLabel,
            style: style,
          ),
        )
      : showDialog(
          context: context,
          builder: (context) => MaterialTextInputDialog(
            textFields: textFields,
            titleLabel: titleLabel,
            okLabel: okLabel,
            cancelLabel: cancelLabel,
            messageLabel: messageLabel,
            style: style,
          ),
        );
}

// TODO(mono): Add more options
@immutable
class DialogTextField {
  const DialogTextField({
    this.initialText,
    this.hintText,
    this.obscureText = false,
  });
  final String initialText;
  final String hintText;
  final bool obscureText;
}
