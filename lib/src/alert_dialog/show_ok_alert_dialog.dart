import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

/// Show OK alert dialog, whose appearance is adaptive according to platform
///
/// This is convenient wrapper of [showAlertDialog].
/// [barrierDismissible] (default: true) only works for material style,
/// and if it is set to false, pressing OK button is only way to close alert.
/// [actionsOverflowDirection] works only for Material style currently.
Future<OkCancelResult> showOkAlertDialog({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
  TextStyle okTextStyle = const TextStyle(),
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
}) async {
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
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        textStyle: okTextStyle,
      )
    ],
  );
  return result ?? OkCancelResult.cancel;
}
