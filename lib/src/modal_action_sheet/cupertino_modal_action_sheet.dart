import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';
import 'package:adaptive_dialog/src/helper/adaptive_selection_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoModalActionSheet<T> extends StatelessWidget {
  const CupertinoModalActionSheet({
    super.key,
    required this.onPressed,
    required this.actions,
    this.title,
    this.message,
    this.cancelLabel,
    required this.canPop,
    required this.onPopInvokedWithResult,
    this.selectionMode,
  });

  final ActionCallback<T> onPressed;
  final List<SheetAction<T>> actions;
  final String? title;
  final String? message;
  final String? cancelLabel;
  final bool canPop;
  final PopInvokedWithResultCallback<T>? onPopInvokedWithResult;
  final AdaptiveSelectionMode? selectionMode;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final message = this.message;
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: MediaQuery.withClampedTextScaling(
        minScaleFactor: 1,
        child: CupertinoActionSheet(
          title: title == null
              ? null
              : AdaptiveSelectionArea(
                  mode: selectionMode,
                  child: Text(title),
                ),
          message: message == null
              ? null
              : AdaptiveSelectionArea(
                  mode: selectionMode,
                  child: Text(message),
                ),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: !actions.any((a) => a.isDefaultAction),
            onPressed: () => onPressed(null),
            child: Text(
              cancelLabel ??
                  MaterialLocalizations.of(
                    context,
                  ).cancelButtonLabel.capitalizedForce,
            ),
          ),
          actions: actions
              .map(
                (a) => CupertinoActionSheetAction(
                  isDestructiveAction: a.isDestructiveAction,
                  isDefaultAction: a.isDefaultAction,
                  onPressed: () => onPressed(a.key),
                  child: Text(
                    a.label,
                    style: a.textStyle,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
