import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import 'alert_dialog_action.dart';

export 'alert_dialog_action.dart';

/// Show alert dialog, whose appearance is adaptive according to platform
///
/// [useActionSheetForCupertino] (default: false) only works for
/// cupertino style. If it is set to true, [showModalActionSheet] is called
/// instead.
Future<T> showAlertDialog<T>({
  @required BuildContext context,
  String title,
  String message,
  List<AlertDialogAction<T>> actions = const [],
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
      cancelLabel: actions.findCancelLabel(),
      actions: actions.convertToSheetActions(),
      style: style,
    );
  }
  final titleText = title == null ? null : Text(title);
  final messageText = message == null ? null : Text(message);
  return style.isCupertinoStyle(theme)
      ? showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: titleText,
            content: messageText,
            actions: actions.convertToCupertinoDialogActions(
              onPressed: pop,
            ),
          ),
        )
      : showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (context) => AlertDialog(
            title: titleText,
            content: messageText,
            actions: actions.convertToMaterialDialogActions(
              onPressed: pop,
              destructiveColor: colorScheme.error,
            ),
          ),
        );
}

/// Show OK/Cancel alert dialog, whose appearance is adaptive according to platform
///
/// This is convenient wrapper of [showAlertDialog].
/// [barrierDismissible] (default: true) only works for material style,
/// and if it is set to false, pressing OK or Cancel buttons is only way to
/// close alert.
/// [defaultType] only works for cupertino style and if it is specified
/// OK or Cancel button label will be changed to bold.
Future<OkCancelResult> showOkCancelAlertDialog({
  @required BuildContext context,
  String title,
  String message,
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

/// Show OK alert dialog, whose appearance is adaptive according to platform
///
/// This is convenient wrapper of [showAlertDialog].
/// [barrierDismissible] (default: true) only works for material style,
/// and if it is set to false, pressing OK button is only way to close alert.
Future<OkCancelResult> showOkAlertDialog({
  @required BuildContext context,
  String title,
  String message,
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

// Used to specify [showOkCancelAlertDialog]'s [defaultType]
enum OkCancelAlertDefaultType {
  ok,
  cancel,
}
