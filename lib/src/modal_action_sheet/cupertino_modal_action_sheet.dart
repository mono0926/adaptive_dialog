import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';
import 'sheet_action.dart';

class CupertinoModalActionSheet<T> extends StatelessWidget {
  const CupertinoModalActionSheet({
    Key key,
    @required this.onPressed,
    this.title,
    this.message,
    this.actions,
    this.cancelLabel,
  }) : super(key: key);

  final ActionCallback<T> onPressed;
  final String title;
  final String message;
  final List<SheetAction<T>> actions;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: title == null ? null : Text(title),
      message: message == null ? null : Text(message),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          cancelLabel ??
              MaterialLocalizations.of(context)
                  .cancelButtonLabel
                  .capitalizedForce,
        ),
        isDefaultAction: !actions.any((a) => a.isDefaultAction),
        onPressed: () => onPressed(null),
      ),
      actions: actions
          .map((a) => CupertinoActionSheetAction(
                child: Text(a.label),
                isDestructiveAction: a.isDestructiveAction,
                isDefaultAction: a.isDefaultAction,
                onPressed: () => onPressed(a.key),
              ))
          .toList(),
    );
  }
}
