import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

class AdaptiveDialog {
  AdaptiveDialog._();
  static AdaptiveDialog? _instance;
  // ignore: prefer_constructors_over_static_methods
  static AdaptiveDialog get instance => _instance ??= AdaptiveDialog._();

  var _defaultStyle = AdaptiveStyle.adaptive;
  var _macOsConfiguration = AdaptiveDialogMacOSConfiguration();
  AdaptiveDialogMacOSConfiguration get macOSConfiguration =>
      _macOsConfiguration;
  AdaptiveStyle get defaultStyle => _defaultStyle;

  // ignore: use_setters_to_change_properties
  void updateConfiguration({
    AdaptiveStyle? defaultStyle,
    AdaptiveDialogMacOSConfiguration? macOS,
  }) {
    _defaultStyle = defaultStyle ?? _defaultStyle;
    _macOsConfiguration = macOS ?? _macOsConfiguration;
  }
}

class AdaptiveDialogMacOSConfiguration {
  AdaptiveDialogMacOSConfiguration({
    this.applicationIcon,
  });

  final Widget? applicationIcon;
}
