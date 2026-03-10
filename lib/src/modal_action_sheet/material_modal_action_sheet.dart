import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:adaptive_dialog/src/helper/adaptive_selection_area.dart';
import 'package:flutter/material.dart';

class MaterialModalActionSheet<T> extends StatelessWidget {
  const MaterialModalActionSheet({
    super.key,
    required this.onPressed,
    required this.actions,
    this.title,
    this.message,
    this.materialConfiguration,
    required this.canPop,
    required this.onPopInvokedWithResult,
    this.selectionMode,
  });

  final ActionCallback<T> onPressed;
  final List<SheetAction<T>> actions;
  final String? title;
  final String? message;
  final MaterialModalActionSheetConfiguration? materialConfiguration;
  final bool canPop;
  final PopInvokedWithResultCallback<T>? onPopInvokedWithResult;
  final AdaptiveSelectionMode? selectionMode;

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
          title: AdaptiveSelectionArea(
            mode: selectionMode,
            child: Text(title),
          ),
          dense: true,
        ),
      if (title == null && message != null)
        ListTile(
          title: AdaptiveSelectionArea(
            mode: selectionMode,
            child: Text(
              message,
              style: theme.textTheme.bodySmall,
            ),
          ),
          dense: true,
        ),
      if (title != null && message != null) ...[
        ListTile(
          title: AdaptiveSelectionArea(
            mode: selectionMode,
            child: Text(title),
          ),
          subtitle: AdaptiveSelectionArea(
            mode: selectionMode,
            child: Text(message),
          ),
        ),
        const Divider(),
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
            ).merge(a.textStyle),
          ),
          onTap: () => onPressed(a.key),
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
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: body,
    );
  }
}
