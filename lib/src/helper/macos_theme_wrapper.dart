import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class MacThemeWrapper extends StatefulWidget {
  const MacThemeWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MacThemeWrapper> createState() => _MacThemeWrapperState();
}

class _MacThemeWrapperState extends State<MacThemeWrapper> {
  final accentColor = DynamicColorPlugin.getAccentColor();

  @override
  Widget build(BuildContext context) {
    if (MacosTheme.maybeOf(context) != null) {
      return widget.child;
    }
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return FutureBuilder<Color?>(
      future: accentColor,
      builder: (context, snapshot) {
        final accentColor = snapshot.data;
        if (accentColor != null) {
          AdaptiveDialog.instance.cacheAccentColor(accentColor);
        }
        return MacosTheme(
          data: (Theme.of(context).brightness == Brightness.light
                  ? MacosThemeData.light()
                  : MacosThemeData.dark())
              .copyWith(
            pushButtonTheme: PushButtonThemeData(
              color: AdaptiveDialog.instance.cachedAccentColor ??
                  theme.cupertinoOverrideTheme?.primaryColor ??
                  colorScheme.primary,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
