import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

class AdaptiveSelectionArea extends StatelessWidget {
  const AdaptiveSelectionArea({
    super.key,
    required this.child,
    this.mode,
  });

  final Widget child;
  final AdaptiveSelectionMode? mode;

  @override
  Widget build(BuildContext context) {
    final effectiveMode = mode ?? AdaptiveDialog.instance.selectionMode;
    if (effectiveMode.isSelectable) {
      return SelectionArea(child: child);
    }
    return child;
  }
}
