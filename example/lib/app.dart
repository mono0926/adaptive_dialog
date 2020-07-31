import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'adaptive_dialog Demo';
    return MaterialApp(
      title: title,
      home: const HomePage(title: title),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      onGenerateRoute: context.watch<Router>().onGenerateRoute,
    );
  }
}
