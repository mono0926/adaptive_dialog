import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showTextAnswerDialog({
  @required BuildContext context,
  @required String keyword,
  String title,
  String message,
  String okLabel,
  String cancelLabel,
  bool isDestructiveAction = false,
  String hintText,
  String retryTitle,
  String retryMessage,
  String retryOkLabel,
  String retryCancelLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) async {
  final texts = await showTextInputDialog(
    context: context,
    textFields: [
      DialogTextField(hintText: hintText),
    ],
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
    isDestructiveAction: isDestructiveAction,
    style: style,
    actionsOverflowDirection: actionsOverflowDirection,
  );
  final text = texts == null ? null : texts[0];
  if (text == null) {
    return false;
  }
  if (text == keyword) {
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
  );
  return result == OkCancelResult.ok
      ? showTextAnswerDialog(
          context: context,
          keyword: keyword,
          title: title,
          message: message,
          okLabel: okLabel,
          cancelLabel: cancelLabel,
          isDestructiveAction: isDestructiveAction,
          hintText: hintText,
          retryTitle: retryTitle,
          retryMessage: retryMessage,
          retryOkLabel: retryOkLabel,
          retryCancelLabel: retryCancelLabel,
          style: style,
          actionsOverflowDirection: actionsOverflowDirection,
        )
      : Future.value(false);
}
