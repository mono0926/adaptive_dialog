import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/app.dart';
import 'package:example/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(App.title),
        actions: const [
          _StyleDropdownButton(),
        ],
      ),
      body: ListView(
        children: [
          ...allRouteLocations.map((location) {
            return ListTile(
              title: Text(pascalCaseFromRouteName(location)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(location),
            );
          }),
          const Divider(),
          AboutListTile(
            icon: const Icon(Icons.info),
            aboutBoxChildren: [
              TextButton.icon(
                label: const Text('adaptive_dialog | pub.dev'),
                onPressed: () =>
                    launch('https://pub.dev/packages/adaptive_dialog'),
                icon: const Icon(Icons.open_in_browser),
              ),
            ],
          ),
          ListTile(
            title: const Text('adaptive_dialog | pub.dev'),
            onTap: () => launch('https://pub.dev/packages/adaptive_dialog'),
            leading: const Icon(Icons.open_in_browser),
          )
        ],
      ),
    );
  }
}

class _StyleDropdownButton extends ConsumerWidget {
  const _StyleDropdownButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: DropdownButton<AdaptiveStyle>(
          value: ref.watch(adaptiveStyleNotifier),
          items: AdaptiveStyle.values
              .map(
                (style) => DropdownMenuItem(
                  value: style,
                  child: Text(
                    style.name.pascalCase,
                  ),
                ),
              )
              .toList(),
          onChanged: (style) =>
              ref.read(adaptiveStyleNotifier.notifier).update((_) => style!),
        ),
      ),
    );
  }
}

final adaptiveStyleNotifier = StateProvider((ref) => AdaptiveStyle.adaptive);

extension AdaptiveStyleX on AdaptiveStyle {
  TargetPlatform? get platform {
    switch (this) {
      case AdaptiveStyle.material:
        return TargetPlatform.android;
      case AdaptiveStyle.cupertino:
        return TargetPlatform.iOS;
      case AdaptiveStyle.adaptive:
        return null;
    }
  }
}
