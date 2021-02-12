import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

class NestedNavigatorPage extends StatelessWidget {
  const NestedNavigatorPage({Key? key}) : super(key: key);

  static const routeName = '/nested_navigator';

  @override
  Widget build(BuildContext context) {
    final initialRoute = routeName.replaceFirst('/', '');
    return Navigator(
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        assert(settings.name == initialRoute);
        return MaterialPageRoute<void>(
          builder: (context) => const _RootPage(),
        );
      },
    );
  }
}

class _RootPage extends StatelessWidget {
  const _RootPage({Key? key}) : super(key: key);
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
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (context) => const _RootPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
