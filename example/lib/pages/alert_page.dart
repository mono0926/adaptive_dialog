import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router.dart';
import 'package:example/util/logger.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key key}) : super(key: key);

  static const routeName = '/alert';

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteName(AlertPage.routeName)),
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
            title: const Text('OK Dialog (barrierDismissible: false)'),
            onTap: () async {
              final result = await showOkAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                barrierDismissible: false,
              );
              assert(result == OkCancelResult.ok);
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
          ListTile(
            title: const Text('OK/Cancel Dialog (Destructive)'),
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'Title',
                message: 'This is message.',
                isDestructiveAction: true,
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
                useActionSheetForCupertino: true,
              );
              logger.info(result);
            },
          ),
        ],
      ),
    );
  }
}
