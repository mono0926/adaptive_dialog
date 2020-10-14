import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show alert dialog, whose appearance is adaptive according to platform
///
/// [useActionSheetForCupertino] (default: false) only works for
/// cupertino style. If it is set to true, [showModalActionSheet] is called
/// instead.
/// [actionsOverflowDirection] works only for Material style currently.
Future<T> showAlertDialog<T>({
  @required BuildContext context,
  String title,
  String message,
  List<AlertDialogAction<T>> actions = const [],
  bool barrierDismissible = true,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
}) {
  void pop(T key) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isCupertinoStyle = style.isCupertinoStyle(theme);
  if (isCupertinoStyle && useActionSheetForCupertino) {
    return showModalActionSheet(
      context: context,
      title: title,
      message: message,
      cancelLabel: actions.findCancelLabel(),
      actions: actions.convertToSheetActions(),
      style: style,
      useRootNavigator: useRootNavigator,
    );
  }
  final titleText = title == null ? null : Text(title);
  final messageText = message == null ? null : Text(message);
  return style.isCupertinoStyle(theme)
      ? showCupertinoDialog(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (context) => CupertinoAlertDialog(
            title: titleText,
            content: messageText,
            actions: actions.convertToCupertinoDialogActions(
              onPressed: pop,
            ),
            // TODO(mono): Set actionsOverflowDirection if available
            // https://twitter.com/_mono/status/1261122914218160128
          ),
        )
      : showModal(
          context: context,
          useRootNavigator: useRootNavigator,
          configuration: FadeScaleTransitionConfiguration(
            barrierDismissible: barrierDismissible,
          ),
          builder: (context) => AlertDialog(
            title: titleText,
            content: messageText,
            actions: actions.convertToMaterialDialogActions(
              onPressed: pop,
              destructiveColor: colorScheme.error,
              fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
            ),
            actionsOverflowDirection: actionsOverflowDirection,
          ),
        );
}

// Used to specify [showOkCancelAlertDialog]'s [defaultType]
enum OkCancelAlertDefaultType {
  ok,
  cancel,
}
