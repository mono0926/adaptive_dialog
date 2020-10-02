import 'package:example/router.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Router()),
      ],
      child: const App(),
    ),
  );
}
