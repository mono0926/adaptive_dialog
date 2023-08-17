import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/router/router.dart';
import 'package:example/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TextInputDialogRoute extends GoRouteData {
  const TextInputDialogRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TextInputDialogPage();
}

class TextInputDialogPage extends ConsumerWidget {
  const TextInputDialogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pascalCaseFromRouteUri(GoRouterState.of(context).uri)),
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
                    maxLength: 24,
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
                        value!.isEmpty ? 'Input more than one character' : null,
                  ),
                  DialogTextField(
                    hintText: 'hintText',
                    validator: (value) => value!.length < 2
                        ? 'Input more than two characters'
                        : null,
                  ),
                ],
                title: 'Hello',
                message: 'This is a message',
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('Title/Message (Validation・autoSubmit)'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: [
                  DialogTextField(
                    hintText: 'hintText',
                    validator: (value) =>
                        value!.isEmpty ? 'Input more than one character' : null,
                  ),
                  DialogTextField(
                    hintText: 'hintText',
                    validator: (value) => value!.length < 2
                        ? 'Input more than two characters'
                        : null,
                  ),
                ],
                title: 'Hello',
                message: 'This is a message',
                autoSubmit: true,
              );
              logger.info(text);
            },
          ),
          ListTile(
            title: const Text('Title/Message (Prefix/Suffix)'),
            onTap: () async {
              final text = await showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(
                    hintText: 'hintText',
                    prefixText: '\$',
                    suffixText: 'Dollar',
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
                autoSubmit: true,
                keyword: 'Flutter',
                title: 'What\'s the best mobile application framework?',
                message: 'Input answer and press OK',
                isDestructiveAction: true,
                hintText: 'Start with "F"',
                retryTitle: 'Incorrect',
                retryMessage: 'Retry?',
                retryOkLabel: ref
                        .watch(adaptiveStyleProvider)
                        .effectiveStyle(theme)
                        .isMaterial(theme)
                    ? 'RETRY'
                    : 'Retry',
              );
              logger.info('ok: $ok');
              if (!ok) {
                return;
              }
              // ignore: use_build_context_synchronously
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
