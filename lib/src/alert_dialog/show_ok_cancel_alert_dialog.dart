import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';

/// Show OK/Cancel alert dialog, whose appearance is adaptive according to platform
///
/// This is convenient wrapper of [showAlertDialog].
/// [barrierDismissible] (default: true) only works for material style,
/// and if it is set to false, pressing OK or Cancel buttons is only way to
/// close alert.
/// [defaultType] only works for cupertino style and if it is specified
/// OK or Cancel button label will be changed to bold.
/// [actionsOverflowDirection] works only for Material style currently.
Future<OkCancelResult> showOkCancelAlertDialog({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
  String? cancelLabel,
  OkCancelAlertDefaultType? defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
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
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    onWillPop: onWillPop,
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
