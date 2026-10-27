import 'package:adaptive_dialog/src/action_callback.dart';
import 'package:adaptive_dialog/src/modal_action_sheet/sheet_action.dart';
import 'package:collection/collection.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

/// Used for specifying showAlertDialog's actions.
@immutable
class const AlertDialogAction<T>({
  required final T key,
  required final String label,

  /// Make font weight to bold(Only works for CupertinoStyle).
  final bool isDefaultAction = false,

  /// Make font color to destructive/error color(red).
  final bool isDestructiveAction = false,

  /// Change textStyle to another from default.
  ///
  /// Recommended to keep null.
  final TextStyle textStyle = const TextStyle(),
});

extension AlertDialogActionEx<T> on AlertDialogAction<T> {
  Widget convertToIOSDialogAction({
    required ActionCallback<T> onPressed,
  }) {
    return CupertinoDialogAction(
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      textStyle: textStyle,
      onPressed: () => onPressed(key),
      child: Text(label),
    );
  }

  Widget convertToMaterialDialogAction({
    required ActionCallback<T> onPressed,
    required Color destructiveColor,
    required bool fullyCapitalized,
  }) {
    return TextButton(
      child: Text(
        fullyCapitalized ? label.toUpperCase() : label,
        style: textStyle.copyWith(
          color: isDestructiveAction ? destructiveColor : null,
        ),
      ),
      onPressed: () => onPressed(key),
    );
  }
}

extension AlertDialogActionListEx<T> on List<AlertDialogAction<T>> {
  List<SheetAction<T>> convertToSheetActions() =>
      where((a) => a.key != OkCancelResult.cancel)
          .map(
            (a) => SheetAction(
              key: a.key,
              label: a.label,
              isDefaultAction: a.isDefaultAction,
              isDestructiveAction: a.isDestructiveAction,
              textStyle: a.textStyle,
            ),
          )
          .toList();

  String? findCancelLabel() =>
      firstWhereOrNull((a) => a.key == OkCancelResult.cancel)?.label;
}

// Result type of [showOkAlertDialog] or [showOkCancelAlertDialog].
enum OkCancelResult() {
  ok,
  cancel,
}
