import 'package:example/pages/home_page.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';

import 'router/router.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);
  static const title = 'adaptive_dialog Demo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final platform = ref.watch(
      adaptiveStyleNotifier.select((s) => s.platform),
    );
    return MaterialApp.router(
      title: title,
      theme: lightTheme().copyWith(platform: platform),
      darkTheme: darkTheme().copyWith(platform: platform),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
