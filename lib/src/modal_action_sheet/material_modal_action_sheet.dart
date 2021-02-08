import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:flutter/material.dart';
import 'modal_action_sheet.dart';
import 'sheet_action.dart';

class MaterialModalActionSheet<T> extends StatelessWidget {
  const MaterialModalActionSheet({
    Key? key,
    required this.onPressed,
    required this.actions,
    this.title,
    this.message,
    this.cancelLabel,
    this.materialConfiguration,
  }) : super(key: key);

  final ActionCallback<T> onPressed;
  final List<SheetAction<T>> actions;
  final String? title;
  final String? message;
  final String? cancelLabel;
  final MaterialModalActionSheetConfiguration? materialConfiguration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final title = this.title;
    final message = this.message;
    final materialConfiguration = this.materialConfiguration;
    final children = [
      if (title != null && message == null)
        ListTile(
          title: Text(title),
          dense: true,
        ),
      if (message != null) ...[
        ListTile(
          title: Text(title!),
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
          onTap: () => onPressed(a.key),
        );
      }),
    ];
    if (materialConfiguration == null) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      );
    }
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: materialConfiguration.initialChildSize,
      minChildSize: materialConfiguration.minChildSize,
      maxChildSize: materialConfiguration.maxChildSize,
      builder: (context, controller) => ListView(
        controller: controller,
        children: children,
      ),
    );
  }
}
