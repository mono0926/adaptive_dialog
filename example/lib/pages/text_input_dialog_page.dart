import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';

class TextInputDialogPage extends StatelessWidget {
  const TextInputDialogPage({Key key}) : super(key: key);

  static const routeName = '/text_input_dialog';

  @override
  Widget build(BuildContext context) {
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
                titleLabel: 'Hello',
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
                  DialogTextField(),
                ],
                titleLabel: 'Hello',
                messageLabel: 'This is a message',
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
                titleLabel: 'Hello',
                messageLabel: 'This is a message',
              );
              logger.info(text);
            },
          ),
        ],
      ),
    );
  }
}
