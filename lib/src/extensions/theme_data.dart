import 'package:flutter/material.dart';

extension ThemeDataEx on ThemeData {
  /// Return true is the platform is suitable for Cupertino(iOS) style
  bool get isCupertinoStyle =>
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
