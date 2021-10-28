import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

typedef AsyncPredicateCallback = Future<bool> Function(String);

Future<bool> showTextCallbackDialog({
  required BuildContext context,
  required AsyncPredicateCallback asyncCallback,
  String? title,
  String? message,
  String? okLabel,
  String? cancelLabel,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  String? hintText,
  String? retryTitle,
  String? retryMessage,
  String? retryOkLabel,
  String? retryCancelLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
  FormFieldValidator<String>? validator
}) async {
  final texts = await showTextInputDialog(
    context: context,
    textFields: [
      DialogTextField(
        hintText: hintText,
        validator: validator
      ),
    ],
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
    isDestructiveAction: isDestructiveAction,
    style: style,
    actionsOverflowDirection: actionsOverflowDirection,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    onWillPop: onWillPop,
  );
  final text = texts == null ? null : texts[0];

  if (text == null) {
    return false;
  }

  if (await asyncCallback(text)) {
    return true;
  }

  final result = await showOkCancelAlertDialog(
    context: context,
    title: retryTitle,
    message: retryMessage,
    okLabel: retryOkLabel,
    cancelLabel: retryCancelLabel,
    defaultType: OkCancelAlertDefaultType.ok,
    actionsOverflowDirection: actionsOverflowDirection,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    onWillPop: onWillPop,
  );
  return result == OkCancelResult.ok
      ? showTextCallbackDialog(
    context: context,
    asyncCallback: asyncCallback,
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
    isDestructiveAction: isDestructiveAction,
    barrierDismissible: barrierDismissible,
    hintText: hintText,
    retryTitle: retryTitle,
    retryMessage: retryMessage,
    retryOkLabel: retryOkLabel,
    retryCancelLabel: retryCancelLabel,
    style: style,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    onWillPop: onWillPop,
  ) : Future.value(false);
}