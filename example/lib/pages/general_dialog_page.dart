import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router/router.dart';
import 'package:example/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneralDialogRoute extends GoRouteData {
  const GeneralDialogRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GeneralDialogPage();
}

class GeneralDialogPage extends StatelessWidget {
  const GeneralDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteName(GoRouter.of(context).location)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('OK Dialog'),
            onTap: () async {
              final result = await showGeneralAdaptiveDialog<Object?>(
                context: context,
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.red,
                  child: Column(
                    children: const [
                      Text('hello'),
                    ],
                  ),
                ),
              );
              logger.info(result);
            },
          ),
        ],
      ),
    );
  }
}
