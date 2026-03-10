import 'package:example/pages/alert_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('AlertPage matches material style', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/alert',
          builder: (context, state) => const AlertPage(),
        ),
      ],
      initialLocation: '/alert',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // OK Dialog
    await tester.tap(find.text('OK Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('This is message.'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsNothing);

    // OK/Cancel Dialog
    await tester.tap(find.text('OK/Cancel Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsNothing);
  });
}
