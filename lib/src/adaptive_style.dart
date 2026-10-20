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

  AdaptiveStyle effectiveStyle(ThemeData data) => switch (this) {
    AdaptiveStyle.material ||
    AdaptiveStyle.cupertino ||
    AdaptiveStyle.iOS ||
    AdaptiveStyle.macOS => this,
    AdaptiveStyle.adaptive => switch (data.platform) {
      TargetPlatform.iOS => AdaptiveStyle.iOS,
      TargetPlatform.macOS => AdaptiveStyle.macOS,
      TargetPlatform.android ||
      TargetPlatform.fuchsia ||
      TargetPlatform.linux ||
      TargetPlatform.windows => AdaptiveStyle.material,
    },
  };

  String get label => switch (this) {
    AdaptiveStyle.adaptive => 'Adaptive',
    AdaptiveStyle.cupertino => 'Cupertino',
    AdaptiveStyle.iOS => 'iOS',
    AdaptiveStyle.macOS => 'macOS',
    AdaptiveStyle.material => 'Material',
  };
}
