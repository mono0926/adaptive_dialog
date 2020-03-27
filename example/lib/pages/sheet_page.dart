import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

class SheetPage extends StatelessWidget {
  const SheetPage({Key key}) : super(key: key);

  static const routeName = '/sheet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteName(SheetPage.routeName)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('No Title/Message'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                actions: [
                  SheetAction(
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
                  SheetAction(
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
                  SheetAction(
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
            title: const Text('Default action'),
            onTap: () async {
              final result = await showModalActionSheet<String>(
                context: context,
                title: 'Title',
                message: 'Message',
                actions: [
                  SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                  SheetAction(
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
                  SheetAction(
                    icon: Icons.info,
                    label: 'Hello',
                    key: 'helloKey',
                  ),
                  SheetAction(
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
        ],
      ),
    );
  }
}
