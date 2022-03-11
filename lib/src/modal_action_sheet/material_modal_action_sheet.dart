import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:flutter/material.dart';
import 'modal_action_sheet.dart';

class MaterialModalActionSheet<T> extends StatelessWidget {
  const MaterialModalActionSheet({
    Key? key,
    required this.onPressed,
    required this.actions,
    this.title,
    this.message,
    this.materialConfiguration,
    this.onWillPop,
  }) : super(key: key);

  final ActionCallback<T> onPressed;
  final List<SheetAction<T>> actions;
  final String? title;
  final String? message;
  final MaterialModalActionSheetConfiguration? materialConfiguration;
  final WillPopCallback? onWillPop;

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
          onTap: () async {
            if (a.onPressed != null) {
              await a.onPressed!();
            }
            onPressed(a.key);
          },
        );
      }),
    ];
    final body = materialConfiguration == null
        ? SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          )
        : DraggableScrollableSheet(
            expand: false,
            initialChildSize: materialConfiguration.initialChildSize,
            minChildSize: materialConfiguration.minChildSize,
            maxChildSize: materialConfiguration.maxChildSize,
            builder: (context, controller) => ListView(
              controller: controller,
              children: children,
            ),
          );
    return WillPopScope(
      onWillPop: onWillPop,
      child: body,
    );
  }
}
