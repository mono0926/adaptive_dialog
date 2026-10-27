import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_ui/material_ui.dart';

class const MacThemeWrapper({
  super.key,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<MacThemeWrapper> createState() => _MacThemeWrapperState();
}

class _MacThemeWrapperState() extends State<MacThemeWrapper> {
  final Future<Color?> accentColor = DynamicColorPlugin.getAccentColor();

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
          data:
              (Theme.of(context).brightness == Brightness.light
                      ? MacosThemeData.light()
                      : MacosThemeData.dark())
                  .copyWith(
                    pushButtonTheme: PushButtonThemeData(
                      color:
                          AdaptiveDialog.instance.cachedAccentColor ??
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
