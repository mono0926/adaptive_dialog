import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<T?> showMacOSAlertDialog<T>({
  required BuildContext context,
  required Widget? titleText,
  required Widget? messageText,
  required List<AlertDialogAction<T>> actions,
  required bool barrierDismissible,
  required AdaptiveStyle adaptiveStyle,
  required bool useRootNavigator,
  required VerticalDirection actionsOverflowDirection,
  required bool fullyCapitalizedForMaterial,
  required bool canPop,
  required PopInvokedWithResultCallback<T>? onPopInvokedWithResult,
  required AdaptiveDialogBuilder? builder,
  required Widget? macOSApplicationIcon,
  required RouteSettings? routeSettings,
  required AdaptiveSelectionMode? selectionMode,
  required Map<ShortcutActivator, VoidCallback> shortcutBindings,
  required void Function({required BuildContext context, required T? key}) pop,
}) {
  return showCupertinoDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      final dialog = CallbackShortcuts(
        bindings: shortcutBindings,
        child: Focus(
          autofocus: true,
          child: PopScope(
            canPop: canPop,
            onPopInvokedWithResult: onPopInvokedWithResult,
            child: CupertinoAlertDialog(
              title: titleText,
              content: messageText,
              actions: actions
                  .map(
                    (a) => a.convertToIOSDialogAction(
                      onPressed: (key) => pop(context: context, key: key),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
