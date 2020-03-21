import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'extensions/extensions.dart';

Future<T> showModalActionSheet<T>({
  @required BuildContext context,
  @required List<SheetAction<T>> actions,
  String title,
  String message,
  String cancelLabel,
  AdaptiveStyle style = AdaptiveStyle.adaptive,
  bool isDismissible = true,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  void pop(T key) => Navigator.of(context).pop(key);

  return style.isCupertinoStyle(theme)
      ? showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: title == null ? null : Text(title),
            message: message == null ? null : Text(message),
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                cancelLabel ??
                    MaterialLocalizations.of(context)
                        .cancelButtonLabel
                        .capitalizedForce,
              ),
              isDefaultAction: !actions.any((a) => a.isDefaultAction),
              onPressed: () => pop(null),
            ),
            actions: actions
                .map(
                  (a) => CupertinoActionSheetAction(
                    child: Text(a.label),
                    isDestructiveAction: a.isDestructiveAction,
                    isDefaultAction: a.isDefaultAction,
                    onPressed: () => pop(a.key),
                  ),
                )
                .toList(),
          ),
        )
      : showModalBottomSheet(
          context: context,
          isDismissible: isDismissible,
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null && message == null)
                  ListTile(
                    title: Text(title),
                    dense: true,
                  ),
                if (message != null) ...[
                  ListTile(
                    title: Text(title),
                    subtitle: Text(message),
                  ),
                  const Divider()
                ],
                ...actions.map(
                  (a) {
                    final color =
                        a.isDestructiveAction ? colorScheme.error : null;
                    return ListTile(
                      leading: Icon(
                        a.icon,
                        color: color,
                      ),
                      title: Text(
                        a.label,
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                      onTap: () => pop(a.key),
                    );
                  },
                ),
              ],
            ),
          ),
        );
}

@immutable
class SheetAction<T> {
  const SheetAction({
    @required this.label,
    @required this.icon,
    this.key,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });

  final String label;

  /// Only works for Material Style
  final IconData icon;

  /// Used for checking selection result
  final T key;

  /// Make font weight to bold(Only works for CupertinoStyle).
  final bool isDefaultAction;

  /// Make font color to destructive/error color(red).
  final bool isDestructiveAction;
}
