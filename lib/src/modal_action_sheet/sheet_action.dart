import 'package:flutter/widgets.dart';

/// Used for specifying showModalActionSheet's actions.
@immutable
class const SheetAction<T>({
  required final String label,
  final TextStyle textStyle = const TextStyle(),

  /// Used for checking selection result
  final T? key,

  /// Only works for Material Style
  final IconData? icon,

  /// Make font weight to bold(Only works for CupertinoStyle).
  final bool isDefaultAction = false,

  /// Make font color to destructive/error color(red).
  final bool isDestructiveAction = false,
});
