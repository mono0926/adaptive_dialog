import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router/router.dart';
import 'package:example/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertRoute extends GoRouteData {
  const AlertRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const AlertPage();
}

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteUri(GoRouterState.of(context).uri)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('OK Dialog'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK Dialog (canPop: false)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                canPop: false,
              );
              assert(result == OkCancelResult.ok);
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK Dialog (barrierDismissible: false)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                barrierDismissible: false,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK Dialog (Custom okLabel)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                okLabel: 'YES!',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK Dialog (No Title)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                message: 'This is message.',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK Dialog (No Message)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK/Cancel Dialog'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK/Cancel Dialog (Default: Cancel)'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                defaultType: OkCancelAlertDefaultType.cancel,
              );
              logger.info(result);
            },
          ),
          const ListTile(
            title: Text('OK/Cancel Dialog (Destructive)'),
          ),
          ListTile(
            title: const Text('OK/Cancel Dialog (Theme builder)'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                isDestructiveAction: true,
                builder: (context, child) => Theme(
                  data: ThemeData(
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange,
                      ),
                    ),
                    // If this is commented out, the color for cupertino will be default blue/red.
                    cupertinoOverrideTheme: const CupertinoThemeData(
                      primaryColor: Colors.purple,
                    ),
                  ),
                  child: child,
                ),
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK/Cancel Dialog (long button label)'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                okLabel: 'Long OK' * 2,
                cancelLabel: 'Long Cancel' * 2,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('OK/Cancel Dialog (useActionSheetForCupertino)'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                isDestructiveAction: true,
                cancelLabel: 'No!',
                useActionSheetForIOS: true,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text(
              'Yes/No Dialog (fullyCapitalizedForMaterial: true)',
            ),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                okLabel: 'Yes',
                cancelLabel: 'Decline It',
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text(
              'Yes/No Dialog (fullyCapitalizedForMaterial: false)',
            ),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                okLabel: 'Yes',
                cancelLabel: 'Decline It',
                fullyCapitalizedForMaterial: false,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Confirmation Dialog (few selections)'),
            onTap: () async {
              final result = await showConfirmationDialog<int>(
                context: context,
                title: 'Title',
                message: 'This is message.',
                actions: [
                  ...List.generate(
                    5,
                    (index) => AlertDialogAction(
                      label: 'Answer $index',
                      key: index,
                    ),
                  ),
                ],
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text(
              'Confirmation Dialog (few selections / default selection)',
            ),
            onTap: () async {
              final result = await showConfirmationDialog<int>(
                context: context,
                title: 'Title',
                message: 'This is message.',
                actions: [
                  ...List.generate(
                    5,
                    (index) => AlertDialogAction(
                      label: 'Answer $index',
                      key: index,
                    ),
                  ),
                ],
                initialSelectedActionKey: 1,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text('Confirmation Dialog (many selections)'),
            onTap: () async {
              final result = await showConfirmationDialog<int>(
                context: context,
                title: 'Title',
                message: 'This is message.',
                actions: [
                  ...List.generate(
                    20,
                    (index) => AlertDialogAction(
                      label: 'Answer $index',
                      key: index,
                    ),
                  ),
                ],
                shrinkWrap: false,
              );
              logger.info(result);
            },
          ),
          ListTile(
            title: const Text(
              'showConfirmationDialog (custom TextStyle)',
            ),
            onTap: () async {
              final result = await showConfirmationDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                actions: [
                  const AlertDialogAction(
                    key: 'a',
                    label: 'A',
                    textStyle: TextStyle(
                      color: Colors.yellow,
                      fontSize: 50,
                    ),
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
