import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SheetRoute extends GoRouteData {
  const SheetRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SheetPage();
}

class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteName(GoRouter.of(context).location)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('No Title/Message'),
            onTap: () async {
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
          ListTile(
            title: const Text('No Message'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
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
          ListTile(
            title: const Text('No Title'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                message: 'Message',
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
          ListTile(
            title: const Text('Title/Message'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
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
          ListTile(
            title: const Text('Title/Message (No Icon)'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
                actions: const [
                  SheetAction(
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                ],
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Theme builder'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                actions: [
                  const SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                ],
                builder: (context, child) => Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: const CupertinoThemeData(
                      primaryColor: Colors.orange,
                    ),
                    listTileTheme: const ListTileThemeData(
                      textColor: Colors.orange,
                      iconColor: Colors.orange,
                    ),
                  ),
                  child: child,
                ),
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Default action'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
                actions: [
                  const SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                  const SheetAction(
                    icon: Icons.refresh,
                    label: 'Default',
                    key: 'defaultKey',
                    isDefaultAction: true,
                  ),
                ],
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Destructive action'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
                actions: [
                  const SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                  const SheetAction(
                    icon: Icons.warning,
                    label: 'Destructive',
                    key: 'destructiveKey',
                    isDestructiveAction: true,
                  ),
                ],
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Title/Message (Many actions)'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
                materialConfiguration:
                    const MaterialModalActionSheetConfiguration(),
                actions: List.generate(
                  20,
                  (index) => SheetAction(
                    icon: Icons.info,
                    label: 'Hello $index',
                    key: 'helloKey $index',
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
