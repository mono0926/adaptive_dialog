import 'dart:math';

import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sheet_action.dart';

class CupertinoModalActionSheet<T> extends StatelessWidget {
  const CupertinoModalActionSheet({
    super.key,
    required this.onPressed,
    required this.actions,
    this.title,
    this.message,
    this.cancelLabel,
    this.onWillPop,
  });

  final ActionCallback<T> onPressed;
  final List<SheetAction<T>> actions;
  final String? title;
  final String? message;
  final String? cancelLabel;
  final WillPopCallback? onWillPop;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final title = this.title;
    final message = this.message;
    return WillPopScope(
      onWillPop: onWillPop,
      child: MediaQuery(
        data: mediaQuery.copyWith(
          // `CupertinoAlertDialog` overrides textScaleFactor
          // to keep larger than 1, but `CupertinoActionSheet` doesn't.
          // https://twitter.com/_mono/status/1266997626693509126
          textScaleFactor: max(1, mediaQuery.textScaleFactor),
        ),
        child: CupertinoActionSheet(
          title: title == null ? null : Text(title),
          message: message == null ? null : Text(message),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: !actions.any((a) => a.isDefaultAction),
            onPressed: () => onPressed(null),
            child: Text(
              cancelLabel ??
                  MaterialLocalizations.of(context)
                      .cancelButtonLabel
                      .capitalizedForce,
            ),
          ),
          actions: actions
              .map(
                (a) => CupertinoActionSheetAction(
                  isDestructiveAction: a.isDestructiveAction,
                  isDefaultAction: a.isDefaultAction,
                  onPressed: () => onPressed(a.key),
                  child: Text(a.label),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
