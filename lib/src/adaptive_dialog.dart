import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

class AdaptiveDialog {
  AdaptiveDialog._();
  static AdaptiveDialog? _instance;
  // ignore: prefer_constructors_over_static_methods
  static AdaptiveDialog get instance => _instance ??= AdaptiveDialog._();

  var _defaultStyle = AdaptiveStyle.adaptive;
  var _macOs = AdaptiveDialogMacOSConfiguration();

  AdaptiveStyle get defaultStyle => _defaultStyle;
  AdaptiveDialogMacOSConfiguration get macOS => _macOs;

  // ignore: use_setters_to_change_properties
  void updateConfiguration({
    AdaptiveStyle? defaultStyle,
    AdaptiveDialogMacOSConfiguration? macOS,
  }) {
    _defaultStyle = defaultStyle ?? _defaultStyle;
    _macOs = macOS ?? _macOs;
  }
}

class AdaptiveDialogMacOSConfiguration {
  AdaptiveDialogMacOSConfiguration({
    this.enabled = true,
    this.applicationIcon,
  });

  final bool enabled;
  final Widget? applicationIcon;
}
