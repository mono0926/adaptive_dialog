import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/app.dart';
import 'package:example/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                onPressed: _launchPubSite,
                icon: const Icon(Icons.open_in_browser),
              ),
            ],
          ),
          ListTile(
            title: const Text('adaptive_dialog | pub.dev'),
            onTap: _launchPubSite,
            leading: const Icon(Icons.open_in_browser),
          )
        ],
      ),
    );
  }

  void _launchPubSite() => launchUrl(
        Uri.parse('https://pub.dev/packages/adaptive_dialog'),
      );
}

class _StyleDropdownButton extends ConsumerWidget {
  const _StyleDropdownButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: DropdownButton<AdaptiveStyle>(
          value: ref.watch(adaptiveStyleProvider),
          items: AdaptiveStyle.values
              // ignore: deprecated_member_use
              .where((style) => style != AdaptiveStyle.cupertino)
              .map(
                (style) => DropdownMenuItem(
                  value: style,
                  child: Text(style.label),
                ),
              )
              .toList(),
          onChanged: (style) =>
              ref.read(adaptiveStyleProvider.notifier).update(style!),
        ),
      ),
    );
  }
}

final adaptiveStyleProvider =
    StateNotifierProvider<AdaptiveStyleNotifier, AdaptiveStyle>(
  (ref) => AdaptiveStyleNotifier(),
);

class AdaptiveStyleNotifier extends StateNotifier<AdaptiveStyle> {
  AdaptiveStyleNotifier() : super(AdaptiveStyle.adaptive);
  void update(AdaptiveStyle style) {
    AdaptiveDialog.instance.updateConfiguration(defaultStyle: style);
    state = style;
  }
}
