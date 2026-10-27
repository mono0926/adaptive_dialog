import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:material_ui/material_ui.dart';

class const AdaptiveSelectionArea({
  super.key,
  required final Widget child,
  final AdaptiveSelectionMode? mode,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final effectiveMode = mode ?? AdaptiveDialog.instance.selectionMode;
    if (effectiveMode.isSelectable) {
      return SelectionArea(child: child);
    }
    return child;
  }
}
