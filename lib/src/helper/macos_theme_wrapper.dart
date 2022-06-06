import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class MacThemeWrapper extends StatelessWidget {
  const MacThemeWrapper({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (MacosTheme.maybeOf(context) != null) {
      return child;
    }
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return MacosTheme(
      data: (Theme.of(context).brightness == Brightness.light
              ? MacosThemeData.light()
              : MacosThemeData.dark())
          .copyWith(
        pushButtonTheme: PushButtonThemeData(
          color:
              theme.cupertinoOverrideTheme?.primaryColor ?? colorScheme.primary,
        ),
      ),
      child: child,
    );
  }
}
