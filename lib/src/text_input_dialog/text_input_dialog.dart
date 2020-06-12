import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/text_input_dialog/cupertino_text_input_dialog.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'material_text_input_dialog.dart';

Future<List<String>> showTextInputDialog({
  @required BuildContext context,
  @required List<DialogTextField> textFields,
  String title,
  String message,
  String okLabel,
  String cancelLabel,
  bool isDestructiveAction = false,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) {
  final theme = Theme.of(context);
  return style.isCupertinoStyle(theme)
      ? showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoTextInputDialog(
            textFields: textFields,
            title: title,
            message: message,
            okLabel: okLabel,
            cancelLabel: cancelLabel,
            isDestructiveAction: isDestructiveAction,
            style: style,
          ),
        )
      : showModal(
          context: context,
          builder: (context) => MaterialTextInputDialog(
            textFields: textFields,
            title: title,
            message: message,
            okLabel: okLabel,
            cancelLabel: cancelLabel,
            isDestructiveAction: isDestructiveAction,
            style: style,
            actionsOverflowDirection: actionsOverflowDirection,
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
