import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
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
  var _selectionMode = AdaptiveSelectionMode.desktop;
  Color? _cachedAccentColor;

  AdaptiveStyle get defaultStyle => _defaultStyle;
  AdaptiveDialogMacOSConfiguration get macOS => _macOS;
  AdaptiveSelectionMode get selectionMode => _selectionMode;
  Color? get cachedAccentColor => _cachedAccentColor;

  /// Update default configuration
  void updateConfiguration({
    AdaptiveStyle? defaultStyle,
    AdaptiveDialogMacOSConfiguration? macOS,
    AdaptiveSelectionMode? selectionMode,
  }) {
    _defaultStyle = defaultStyle ?? _defaultStyle;
    _macOS = macOS ?? _macOS;
    _selectionMode = selectionMode ?? _selectionMode;
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

/// Adaptive selection mode
enum AdaptiveSelectionMode {
  /// No selectable text
  none,

  /// Selectable text only for Web and Desktop (macOS, Windows, Linux)
  desktop,

  /// Selectable text for all platforms
  all,
}

extension AdaptiveSelectionModeExtension on AdaptiveSelectionMode {
  /// Returns true if text should be selectable on the current platform
  bool get isSelectable {
    switch (this) {
      case AdaptiveSelectionMode.none:
        return false;
      case AdaptiveSelectionMode.desktop:
        return kIsWeb ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux;
      case AdaptiveSelectionMode.all:
        return true;
    }
  }
}
