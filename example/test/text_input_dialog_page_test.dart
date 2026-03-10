import 'package:example/pages/text_input_dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('TextInputDialogPage test - Enter key', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/text-input',
          builder: (context, state) => const TextInputDialogPage(),
        ),
      ],
      initialLocation: '/text-input',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Open dialog
    await tester.tap(find.text('Title/Message'));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);

    // Enter some text
    await tester.enterText(find.byType(TextField), 'test input enter');

    // Simulate Enter key
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    // Dialog should be closed
    expect(find.text('Hello'), findsNothing);
  });

  testWidgets('TextInputDialogPage test - Escape key', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/text-input',
          builder: (context, state) => const TextInputDialogPage(),
        ),
      ],
      initialLocation: '/text-input',
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Open dialog
    await tester.tap(find.text('Title/Message'));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);

    // Simulate Escape key
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    // Dialog should be closed (cancelled)
    expect(find.text('Hello'), findsNothing);
  });
}
