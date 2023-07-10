import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/helper/macos_theme_wrapper.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:meta/meta.dart';

/// Show alert dialog, whose appearance is adaptive according to platform
///
/// [barrierDismissible] (default: true) only works for Material style.
/// [useActionSheetForIOS] (default: false) only works for
/// iOS style. If it is set to true, [showModalActionSheet] is called
/// instead.
/// [actionsOverflowDirection] works only for Material style currently.
@useResult
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
  RouteSettings? routeSettings,
}) {
  void pop({required BuildContext context, required T? key}) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);

  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final adaptiveStyle = style ?? AdaptiveDialog.instance.defaultStyle;
  final isIOSStyle = adaptiveStyle.effectiveStyle(theme) == AdaptiveStyle.iOS;
  if (isIOSStyle && (useActionSheetForCupertino || useActionSheetForIOS)) {
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
      routeSettings: routeSettings,
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
        routeSettings: routeSettings,
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
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
              // TODO(mono): Set actionsOverflowDirection if available
              // https://twitter.com/_mono/status/1261122914218160128
            ),
          );
          return builder == null ? dialog : builder(context, dialog);
        },
      );
    case AdaptiveStyle.macOS:
      final buttons = actions
          .map(
            (a) => a.convertToMacOSDialogAction(
              onPressed: (key) => pop(context: context, key: key),
            ),
          )
          .intersperse(const SizedBox(height: 8))
          .toList()
          .reversed
          .toList();
      return showMacosAlertDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        builder: (context) {
          final Widget dialog = MacThemeWrapper(
            child: WillPopScope(
              onWillPop: onWillPop,
              child: MacosAlertDialog(
                title: titleText ?? const SizedBox.shrink(),
                message: messageText ?? const SizedBox.shrink(),
                primaryButton: const _DummyEmptyMacosPushButton(),
                suppress: Column(
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
        routeSettings: routeSettings,
        configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: barrierDismissible,
        ),
        builder: (context) {
          final dialog = WillPopScope(
            onWillPop: onWillPop,
            child: AlertDialog(
              title: titleText,
              content: messageText,
              actions: actions
                  .map(
                    (a) => a.convertToMaterialDialogAction(
                      onPressed: (key) => pop(context: context, key: key),
                      destructiveColor: colorScheme.error,
                      fullyCapitalized: fullyCapitalizedForMaterial,
                    ),
                  )
                  .toList(),
              actionsOverflowDirection: actionsOverflowDirection,
              scrollable: true,
            ),
          );
          return builder == null ? dialog : builder(context, dialog);
        },
      );
    case AdaptiveStyle.adaptive:
      assert(false);
      return Future.value();
  }
}

// Used to specify [showOkCancelAlertDialog]'s [defaultType]
enum OkCancelAlertDefaultType {
  ok,
  cancel,
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
