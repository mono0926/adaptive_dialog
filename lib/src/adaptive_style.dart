import 'package:flutter/material.dart';
import 'extensions/theme_data.dart';

enum AdaptiveStyle {
  adaptive,
  material,
  cupertino,
}

extension AdaptiveStyleEx on AdaptiveStyle {
  bool isCupertinoStyle(ThemeData theme) =>
      this == AdaptiveStyle.cupertino ||
      (this == AdaptiveStyle.adaptive && theme.isCupertinoStyle);
}
