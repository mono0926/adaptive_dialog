import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

class TextInputDialogPage extends StatelessWidget {
  const TextInputDialogPage({Key key}) : super(key: key);

  static const routeName = '/text_input_dialog';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteName(routeName)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('No Title/Message'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(),
                ],
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('No Message'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(),
                ],
                title: 'Hello',
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('Title/Message'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(
                    hintText: 'hintText',
                  ),
                ],
                title: 'Hello',
                message: 'This is a message',
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('Title/Message (Validation)'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: [
                  DialogTextField(
                    hintText: 'hintText',
                    validator: (value) =>
                        value.isEmpty ? 'Input more than one character' : null,
                  ),
                ],
                title: 'Hello',
                message: 'This is a message',
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('Multi Text Field'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(
                    hintText: 'Email',
                    initialText: 'mono0926@gmail.com',
                  ),
                  DialogTextField(
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ],
                title: 'Hello',
                message: 'This is a message',
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('TextAnswerDialog'),
            onTap: () async {
              final ok = await showTextAnswerDialog(
                context: context,
                keyword: 'Flutter',
                title: 'What\'s the best mobile application framework?',
                message: 'Input answer and press OK',
                isDestructiveAction: true,
                hintText: 'Start with "F"',
                retryTitle: 'Incorrect',
                retryMessage: 'Retry?',
                retryOkLabel: AdaptiveStyle.adaptive.isCupertinoStyle(theme)
                    ? 'Retry'
                    : 'RETRY',
              );
              print('ok: $ok');
              if (!ok) {
                return;
              }
              await showOkAlertDialog(
                context: context,
                title: 'That\'s right👍',
              );
            },
          ),
        ],
      ),
    );
  }
}
