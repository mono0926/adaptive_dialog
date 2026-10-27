import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Router;

import 'router/router.dart';

class App extends ConsumerWidget {
  const App({super.key});
  static const title = 'adaptive_dialog Demo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
