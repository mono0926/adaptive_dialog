import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/helper/macos_theme_wrapper.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:meta/meta.dart';

@useResult
Future<T?> showGeneralAdaptiveDialog<T>({
  required BuildContext context,
  required Widget child,
  GeneralAdaptiveDialogBuilder? builder,
  bool barrierDismissible = true,
  AdaptiveStyle? style,
  bool useRootNavigator = true,
  WillPopCallback? onWillPop,
  Widget? macOSApplicationIcon,
  RouteSettings? routeSettings,
  String? okLabel,
}) {
  final navigator = Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  );
  void pop(T? key) => navigator.pop(key);
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final adaptiveStyle = style ?? AdaptiveDialog.instance.defaultStyle;
  final effectiveStyle = adaptiveStyle.effectiveStyle(theme);
  switch (effectiveStyle) {
    // ignore: deprecated_member_use, deprecated_member_use_from_same_package
    case AdaptiveStyle.cupertino:
    case AdaptiveStyle.iOS:
      return showCupertinoDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
            child: CupertinoAlertDialog(
              title: child,
              content: const SizedBox(),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => pop(null),
                  child: Text(
                    okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
                  ),
                ),
              ],
            ),
          );
          return builder == null
              ? dialog
              : builder(context, effectiveStyle, dialog);
        },
      );
    case AdaptiveStyle.macOS:
      return showMacosAlertDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        builder: (context) {
          final Widget dialog = MacThemeWrapper(
            child: WillPopScope(
              onWillPop: onWillPop,
              child: MacosAlertDialog(
                title: child,
                message: const SizedBox.shrink(),
                appIcon: macOSApplicationIcon ??
                    AdaptiveDialog.instance.macOS.applicationIcon ??
                    const Icon(Icons.info),
                primaryButton: PushButton(
                  buttonSize: ButtonSize.large,
                  // isSecondary: isDestructiveAction || !isDefaultAction,
                  onPressed: () => pop(null),
                  child: Text(
                    okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
                  ),
                ),
              ),
            ),
          );
          return builder == null
              ? dialog
              : builder(context, effectiveStyle, dialog);
        },
      );
    case AdaptiveStyle.material:
      return showModal(
        context: context,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: barrierDismissible,
        ),
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
            child: AlertDialog(
              content: child,
              actions: [
                TextButton(
                  child: Text(
                    okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
                  ),
                  onPressed: () => pop(null),
                )
              ],
            ),
          );
          return builder == null
              ? dialog
              : builder(context, effectiveStyle, dialog);
        },
      );
    case AdaptiveStyle.adaptive:
      assert(false);
      return Future.value();
  }
}

// TODO(mono): 順番あってる？
typedef GeneralAdaptiveDialogBuilder = Widget Function(
  BuildContext context,
  AdaptiveStyle style,
  Widget child,
);
