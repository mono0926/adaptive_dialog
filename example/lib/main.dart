import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  AdaptiveDialog.instance.updateConfiguration(
    macOS: AdaptiveDialogMacOSConfiguration(
      applicationIcon: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _applicationIconImage,
      ),
    ),
  );
  runApp(
    Builder(
      builder: (context) {
        precacheImage(_applicationIconImage.image, context);
        return const ProviderScope(
          child: App(),
        );
      },
    ),
  );
}

final _applicationIconImage = Image.asset(
  'assets/images/love.png',
);
