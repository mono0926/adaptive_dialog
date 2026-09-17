import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:adaptive_dialog/src/helper/macos_theme_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:macos_ui/macos_ui.dart';

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
  final buttons = actions
      .map(
        (a) => _convertToMacOSDialogAction(
          a,
          onPressed: (key) => pop(context: context, key: key),
        ),
      )
      .intersperse(const SizedBox(height: 8))
      .toList()
      .reversed
      .toList();
  return showMacosAlertDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (context) {
      final Widget dialog = MacThemeWrapper(
        child: CallbackShortcuts(
          bindings: shortcutBindings,
          child: Focus(
            autofocus: true,
            child: PopScope(
              canPop: canPop,
              onPopInvokedWithResult: onPopInvokedWithResult,
              child: MacosAlertDialog(
                title: titleText ?? const SizedBox.shrink(),
                message: messageText ?? const SizedBox.shrink(),
                primaryButton: const _DummyEmptyMacosPushButton(),
                suppress: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttons,
                ),
                appIcon:
                    macOSApplicationIcon ??
                    AdaptiveDialog.instance.macOS.applicationIcon ??
                    const Icon(Icons.info),
              ),
            ),
          ),
        ),
      );
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}

Widget _convertToMacOSDialogAction<T>(
  AlertDialogAction<T> action, {
  required ActionCallback<T> onPressed,
}) {
  return PushButton(
    controlSize: ControlSize.large,
    secondary: action.isDestructiveAction || !action.isDefaultAction,
    onPressed: () => onPressed(action.key),
    child: Text(
      action.label,
      style: action.isDestructiveAction
          ? const TextStyle(
              color: CupertinoColors.destructiveRed,
            )
          : null,
    ),
  );
}

class _DummyEmptyMacosPushButton extends PushButton {
  const _DummyEmptyMacosPushButton()
    : super(
        child: const SizedBox.shrink(),
        controlSize: ControlSize.large,
      );
  @override
  PushButtonState createState() => _DummyEmptyMacosPushButtonState();
}

class _DummyEmptyMacosPushButtonState extends PushButtonState {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
