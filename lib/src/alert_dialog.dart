import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'extensions/extensions.dart';

/// Show alert dialog, whose appearance is adaptive according to platform
Future<T> showAlertDialog<T>({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required List<AlertDialogAction<T>> actions,
  bool barrierDismissible = true,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
}) {
  void pop(T key) => Navigator.of(context).pop(key);
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isCupertinoStyle = style.isCupertinoStyle(theme);
  if (isCupertinoStyle && useActionSheetForCupertino) {
    return showModalActionSheet(
      context: context,
      title: title,
      message: message,
      cancelLabel: actions
          .firstWhere(
            (a) => a.key == OkCancelResult.cancel,
            orElse: () => null,
          )
          ?.label,
      actions: actions
          .where((a) => a.key != OkCancelResult.cancel)
          .map((a) => SheetAction(
                key: a.key,
                label: a.label,
                isDefaultAction: a.isDefaultAction,
                isDestructiveAction: a.isDestructiveAction,
                icon: null,
              ))
          .toList(),
      style: style,
    );
  }
  return style.isCupertinoStyle(theme)
      ? showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions
                .map(
                  (a) => CupertinoDialogAction(
                    child: Text(a.label),
                    isDefaultAction: a.isDefaultAction,
                    isDestructiveAction: a.isDestructiveAction,
                    textStyle: a.textStyle,
                    onPressed: () => pop(a.key),
                  ),
                )
                .toList(),
          ),
        )
      : showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions
                .map(
                  (a) => FlatButton(
                    child: Text(
                      a.label,
                      style: a.textStyle.copyWith(
                        color: a.isDestructiveAction ? colorScheme.error : null,
                      ),
                    ),
                    onPressed: () => pop(a.key),
                  ),
                )
                .toList(),
          ),
        );
}

Future<OkCancelResult> showOkCancelAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
  String okLabel,
  String cancelLabel,
  OkCancelAlertDefaultType defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
}) async {
  final isCupertinoStyle = Theme.of(context).isCupertinoStyle;
  String defaultCancelLabel() {
    final label = MaterialLocalizations.of(context).cancelButtonLabel;
    return isCupertinoStyle ? label.capitalizedForce : label;
  }

  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    actions: [
      AlertDialogAction(
        label: cancelLabel ?? defaultCancelLabel(),
        key: OkCancelResult.cancel,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.cancel,
      ),
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.ok,
        isDestructiveAction: isDestructiveAction,
      ),
    ],
  );
  return result ?? OkCancelResult.cancel;
}

Future<OkCancelResult> showOkAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
  String okLabel,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
}) async {
  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    actions: [
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
      )
    ],
  );
  return result ?? OkCancelResult.cancel;
}

@immutable
class AlertDialogAction<T> {
  const AlertDialogAction({
    this.key,
    @required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle = const TextStyle(),
  });

  final T key;
  final String label;

  /// Make font weight to bold(Only works for CupertinoStyle).
  final bool isDefaultAction;

  /// Make font color to destructive/error color(red).
  final bool isDestructiveAction;
  final TextStyle textStyle;
}

enum OkCancelAlertDefaultType {
  ok,
  cancel,
}
enum OkCancelResult {
  ok,
  cancel,
}
