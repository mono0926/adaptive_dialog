import 'package:example/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('Smoke test', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(App.title), findsOneWidget);

    final routes = [
      'Alert',
      'Sheet',
      'TextInput',
      'NestedNavigator',
    ];

    for (final route in routes) {
      final tile = find.widgetWithText(ListTile, route);
      expect(tile, findsOneWidget);
      await tester.tap(tile);
      await tester.pumpAndSettle();

      // Verify we navigated to the page
      if (route == 'NestedNavigator') {
        // NestedNavigatorPage doesn't have a title in AppBar
        expect(find.byType(Navigator), findsNWidgets(2)); // Root + Nested
      } else {
        expect(
          find.descendant(of: find.byType(AppBar), matching: find.text(route)),
          findsOneWidget,
        );
      }

      // Go back
      final appBar = find.byType(AppBar).first;
      final context = tester.element(appBar);
      GoRouter.of(context).go('/');
      await tester.pumpAndSettle();
      expect(find.text(App.title), findsOneWidget);
    }
  });
}
