import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/text_input_dialog/ios_text_input_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<List<String>?> showMacOSTextInputDialog({
  required BuildContext context,
  required List<DialogTextField> textFields,
  required String? title,
  required String? message,
  required String? okLabel,
  required String? cancelLabel,
  required bool isDestructiveAction,
  required AdaptiveStyle style,
  required bool useRootNavigator,
  required VerticalDirection actionsOverflowDirection,
  required bool fullyCapitalizedForMaterial,
  required bool canPop,
  required PopInvokedWithResultCallback<List<String>?>? onPopInvokedWithResult,
  required bool autoSubmit,
  required AdaptiveDialogBuilder? builder,
  required RouteSettings? routeSettings,
  required AdaptiveSelectionMode? selectionMode,
}) {
  return showCupertinoDialog<List<String>?>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (context) {
      final dialog = IOSTextInputDialog(
        textFields: textFields,
        title: title,
        message: message,
        okLabel: okLabel,
        cancelLabel: cancelLabel,
        isDestructiveAction: isDestructiveAction,
        style: style,
        useRootNavigator: useRootNavigator,
        canPop: canPop,
        onPopInvokedWithResult: onPopInvokedWithResult,
        autoSubmit: autoSubmit,
        selectionMode: selectionMode,
      );
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
