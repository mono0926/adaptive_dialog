import 'package:material_ui/material_ui.dart';

extension ThemeDataEx on ThemeData {
  /// Return true is the platform is suitable for Cupertino(iOS) style
  @Deprecated('Will be removed in v2.')
  bool get isCupertinoStyle =>
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
