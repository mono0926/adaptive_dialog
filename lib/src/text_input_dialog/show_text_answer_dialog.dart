import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Show text input dialog until answer matches [keyword] or dialog is
/// cancelled.
///
/// [style] specifies the dialog style. Note that [AdaptiveStyle.macOS]
/// falls back to Cupertino (iOS-style) dialogs on Web platforms.
/// [barrierDismissible] (default: true) only works for Material style.
@useResult
Future<bool> showTextAnswerDialog({
  required BuildContext context,
  required String keyword,
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
  AdaptiveStyle? style,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  @Deprecated('Will be removed in v3') bool fullyCapitalizedForMaterial = false,
  bool canPop = true,
  PopInvokedWithResultCallback<List<String>?>? onPopInvokedWithResult,
  bool autoSubmit = false,
  bool isCaseSensitive = true,
  AdaptiveDialogBuilder? builder,
  AdaptiveSelectionMode? selectionMode,
}) async {
  final adaptiveStyle = style ?? AdaptiveDialog.instance.defaultStyle;
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
    style: adaptiveStyle,
    actionsOverflowDirection: actionsOverflowDirection,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    canPop: canPop,
    onPopInvokedWithResult: onPopInvokedWithResult,
    autoSubmit: autoSubmit,
    builder: builder,
    selectionMode: selectionMode,
  );
  final text = texts == null ? null : texts[0];
  if (text == null) {
    return false;
  }
  if (isCaseSensitive
      ? text == keyword
      : text.toUpperCase() == keyword.toUpperCase()) {
    return true;
  }
  if (!context.mounted) {
    return false;
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
    builder: builder,
    selectionMode: selectionMode,
  );
  if (result == OkCancelResult.ok) {
    if (!context.mounted) {
      return false;
    }
    return await showTextAnswerDialog(
      context: context,
      keyword: keyword,
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
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      autoSubmit: autoSubmit,
      builder: builder,
      selectionMode: selectionMode,
    );
  }
  return false;
}
