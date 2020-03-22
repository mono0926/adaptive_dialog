import 'package:flutter/material.dart';
import 'sheet_action.dart';

class MaterialModalActionSheet<T> extends StatelessWidget {
  const MaterialModalActionSheet({
    Key key,
    this.title,
    this.message,
    this.actions,
    this.cancelLabel,
  }) : super(key: key);

  final String title;
  final String message;
  final List<SheetAction<T>> actions;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SafeArea(
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
          ...actions.map((a) {
            final icon = a.icon;
            final color = a.isDestructiveAction ? colorScheme.error : null;
            return ListTile(
              leading: icon == null
                  ? null
                  : Icon(
                      icon,
                      color: color,
                    ),
              title: Text(
                a.label,
                style: TextStyle(
                  color: color,
                ),
              ),
              onTap: () => Navigator.of(context).pop(a.key),
            );
          }),
        ],
      ),
    );
  }
}
