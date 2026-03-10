import 'package:example/pages/sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('SheetPage test', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/sheet',
          builder: (context, state) => const SheetPage(),
        ),
      ],
      initialLocation: '/sheet',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Title/Message
    await tester.tap(find.text('Title/Message'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Message'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);

    await tester.tap(find.text('Hello'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsNothing);
  });
}
