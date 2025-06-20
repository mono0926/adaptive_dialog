import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

/// Manage common adaptive_dialog settings, etc.
class AdaptiveDialog {
  AdaptiveDialog._() {
    Future(() async {
      _cachedAccentColor = await DynamicColorPlugin.getAccentColor();
    });
  }
  static AdaptiveDialog? _instance;
  // ignore: prefer_constructors_over_static_methods
  static AdaptiveDialog get instance => _instance ??= AdaptiveDialog._();

  var _defaultStyle = AdaptiveStyle.adaptive;
  var _macOS = AdaptiveDialogMacOSConfiguration();
  Color? _cachedAccentColor;

  AdaptiveStyle get defaultStyle => _defaultStyle;
  AdaptiveDialogMacOSConfiguration get macOS => _macOS;
  Color? get cachedAccentColor => _cachedAccentColor;

  /// Update default configuration
  void updateConfiguration({
    AdaptiveStyle? defaultStyle,
    AdaptiveDialogMacOSConfiguration? macOS,
  }) {
    _defaultStyle = defaultStyle ?? _defaultStyle;
    _macOS = macOS ?? _macOS;
  }

  // ignore: use_setters_to_change_properties
  void cacheAccentColor(Color color) {
    _cachedAccentColor = color;
  }
}

/// Manage common macOS settings
class AdaptiveDialogMacOSConfiguration {
  AdaptiveDialogMacOSConfiguration({
    this.applicationIcon,
  });

  /// Used for macOS style dialog
  final Widget? applicationIcon;
}
