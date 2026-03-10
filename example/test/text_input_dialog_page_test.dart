import 'package:example/pages/text_input_dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('TextInputDialogPage test', (tester) async {
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

    // Title/Message
    await tester.tap(find.text('Title/Message'));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('This is a message'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'test input');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsNothing);
  });
}
