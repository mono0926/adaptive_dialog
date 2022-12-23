import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedNavigatorRoute extends GoRouteData {
  const NestedNavigatorRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NestedNavigatorPage();
}

class NestedNavigatorPage extends StatelessWidget {
  const NestedNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute<void>(
        builder: (context) => const _RootPage(),
      ),
    );
  }
}

class _RootPage extends StatelessWidget {
  const _RootPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(
            context,
            rootNavigator: !ModalRoute.of(context)!.canPop,
          ).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          ElevatedButton(
            child: const Text('Dialog'),
            onPressed: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
              );
              logger.info(result);
            },
          ),
          ElevatedButton(
            child: const Text('Sheet'),
            onPressed: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                actions: [
                  const SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                ],
              );
              logger.info(result);
            },
          ),
          const Divider(),
          ElevatedButton(
            child: const Text('Next Page'),
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const _RootPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
