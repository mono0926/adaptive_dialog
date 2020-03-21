import 'package:flutter/material.dart';

extension ThemeDataEx on ThemeData {
  // ignore: lines_longer_than_80_chars
  // TODO(mono): Add platform == TargetPlatform.macOS when it is supported on stable
  bool get isCupertinoStyle =>
      platform == TargetPlatform.iOS; // || platform == TargetPlatform.macOS;
}
