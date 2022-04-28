import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

/// Show alert dialog, whose appearance is adaptive according to platform
///
/// [useActionSheetForIOS] (default: false) only works for
/// iOS style. If it is set to true, [showModalActionSheet] is called
/// instead.
/// [actionsOverflowDirection] works only for Material style currently.
Future<T?> showAlertDialog<T>({
  required BuildContext context,
  String? title,
  String? message,
  List<AlertDialogAction<T>> actions = const [],
  bool barrierDismissible = true,
  AdaptiveStyle? style,
  @Deprecated('Use `useActionSheetForIOS` instead. Will be removed in v2.')
      bool useActionSheetForCupertino = false,
  bool useActionSheetForIOS = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
  AdaptiveDialogBuilder? builder,
  Widget? macOSApplicationIcon,
}) {
  void pop(T? key) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final adaptiveStyle = style ?? AdaptiveDialog.instance.defaultStyle;
  final isIOSStyle = adaptiveStyle.effectiveStyle(theme) == AdaptiveStyle.iOS;
  if (isIOSStyle && useActionSheetForCupertino || useActionSheetForIOS) {
    return showModalActionSheet(
      context: context,
      title: title,
      message: message,
      cancelLabel: actions.findCancelLabel(),
      actions: actions.convertToSheetActions(),
      style: style,
      useRootNavigator: useRootNavigator,
      onWillPop: onWillPop,
      builder: builder,
    );
  }
  final titleText = title == null ? null : Text(title);
  final messageText = message == null ? null : Text(message);

  final effectiveStyle = adaptiveStyle.effectiveStyle(theme);
  switch (effectiveStyle) {
    // ignore: deprecated_member_use_from_same_package
    case AdaptiveStyle.cupertino:
    case AdaptiveStyle.iOS:
      return showCupertinoDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
            child: CupertinoAlertDialog(
              title: titleText,
              content: messageText,
              actions: actions.convertToIOSDialogActions(
                onPressed: pop,
              ),
              // TODO(mono): Set actionsOverflowDirection if available
              // https://twitter.com/_mono/status/1261122914218160128
            ),
          );
          return builder == null ? dialog : builder(context, dialog);
        },
      );
    case AdaptiveStyle.macOS:
      final buttons = actions.convertToMacOSDialogActions(
        onPressed: pop,
        colorScheme: colorScheme,
      );
      return showMacosAlertDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          final Widget dialog = _MacThemeWrapper(
            child: WillPopScope(
              onWillPop: onWillPop,
              child: MacosAlertDialog(
                title: titleText ?? const SizedBox.shrink(),
                message: messageText ?? const SizedBox.shrink(),
                primaryButton: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttons,
                ),
                appIcon: macOSApplicationIcon ??
                    AdaptiveDialog.instance.macOS.applicationIcon ??
                    const Icon(Icons.info),
              ),
            ),
          );
          return builder == null ? dialog : builder(context, dialog);
        },
      );
    case AdaptiveStyle.material:
      return showModal(
        context: context,
        useRootNavigator: useRootNavigator,
        configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: barrierDismissible,
        ),
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
            child: AlertDialog(
              title: titleText,
              content: messageText,
              actions: actions.convertToMaterialDialogActions(
                onPressed: pop,
                destructiveColor: colorScheme.error,
                fullyCapitalized: fullyCapitalizedForMaterial,
              ),
              actionsOverflowDirection: actionsOverflowDirection,
              scrollable: true,
            ),
          );
          return builder == null ? dialog : builder(context, dialog);
        },
      );
    case AdaptiveStyle.adaptive:
      assert(false);
      return Future.value(null);
  }
}

// Used to specify [showOkCancelAlertDialog]'s [defaultType]
enum OkCancelAlertDefaultType {
  ok,
  cancel,
}

class _MacThemeWrapper extends StatelessWidget {
  const _MacThemeWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (MacosTheme.maybeOf(context) != null) {
      return child;
    }
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return MacosTheme(
      data: (Theme.of(context).brightness == Brightness.light
              ? MacosThemeData.light()
              : MacosThemeData.dark())
          .copyWith(
        pushButtonTheme: PushButtonThemeData(
          color:
              theme.cupertinoOverrideTheme?.primaryColor ?? colorScheme.primary,
        ),
      ),
      child: child,
    );
  }
}
