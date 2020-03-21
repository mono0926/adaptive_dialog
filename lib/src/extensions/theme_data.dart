import 'package:flutter/material.dart';

extension ThemeDataEx on ThemeData {
  bool get isCupertinoStyle =>
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
