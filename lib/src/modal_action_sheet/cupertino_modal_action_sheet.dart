import 'dart:math';

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
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(
        // `CupertinoAlertDialog` overrides textScaleFactor
        // to keep larger than 1, but `CupertinoActionSheet` doesn't.
        // https://twitter.com/_mono/status/1262955228892147713
        textScaleFactor: max(1, mediaQuery.textScaleFactor),
      ),
      child: CupertinoActionSheet(
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
      ),
    );
  }
}
