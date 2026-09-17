import 'package:flutter/material.dart';

import 'extensions/theme_data.dart';

/// The visual style of dialogs and sheets.
enum AdaptiveStyle {
  /// Automatically adapt the dialog style based on the current platform.
  ///
  /// - iOS: [AdaptiveStyle.iOS] (Cupertino)
  /// - macOS: [AdaptiveStyle.macOS] (using `macos_ui` on native macOS,
  ///   or falling back to Cupertino on Web platforms)
  /// - Other platforms: [AdaptiveStyle.material]
  adaptive,

  /// Material Design style dialog.
  material,

  @Deprecated('Use `ios` instead. Will be removed in v2.')
  cupertino,

  /// iOS style dialog (Cupertino).
  iOS,

  /// macOS style dialog.
  ///
  /// Uses `macos_ui` widgets on native macOS.
  ///
  /// Note: On Web platforms (both JS and WASM), this falls back to
  /// Cupertino (iOS-style) dialogs to maintain full Web and WASM compatibility.
  macOS;

  @Deprecated('Will be removed in v2.')
  bool isCupertinoStyle(ThemeData theme) =>
      this == AdaptiveStyle.cupertino ||
      (this == AdaptiveStyle.adaptive && theme.isCupertinoStyle);

  bool isMaterial(ThemeData theme) =>
      this == AdaptiveStyle.material ||
      (this == AdaptiveStyle.adaptive &&
          theme.platform == TargetPlatform.android);

  AdaptiveStyle effectiveStyle(ThemeData data) {
    switch (this) {
      case AdaptiveStyle.material:
      case AdaptiveStyle.cupertino:
      case AdaptiveStyle.iOS:
      case AdaptiveStyle.macOS:
        return this;
      case AdaptiveStyle.adaptive:
        switch (data.platform) {
          case TargetPlatform.iOS:
            return AdaptiveStyle.iOS;
          case TargetPlatform.macOS:
            return AdaptiveStyle.macOS;
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.windows:
            return AdaptiveStyle.material;
        }
    }
  }

  String get label {
    switch (this) {
      case AdaptiveStyle.adaptive:
        return 'Adaptive';
      case AdaptiveStyle.cupertino:
        return 'Cupertino';
      case AdaptiveStyle.iOS:
        return 'iOS';
      case AdaptiveStyle.macOS:
        return 'macOS';
      case AdaptiveStyle.material:
        return 'Material';
    }
  }
}
