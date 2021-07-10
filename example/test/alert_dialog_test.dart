// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/app.dart';
import 'package:example/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('OK Dialog', (tester) async {
    await _setupTester(tester);

    await tester.tap(find.widgetWithText(ListTile, 'OK Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('This is message.'), findsOneWidget);
    await tester.tap(find.widgetWithText(FlatButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.text('Result: OkCancelResult.ok'), findsOneWidget);
  });

  testWidgets('OK Dialog (barrierDismissible: false)', (tester) async {
    await _setupTester(tester);

    await tester.tap(
        find.widgetWithText(ListTile, 'OK Dialog (barrierDismissible: false)'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('This is message.'), findsOneWidget);
    await tester.tap(find.widgetWithText(FlatButton, 'OK'));
    await tester.pumpAndSettle();

    expect(find.text('Result: OkCancelResult.ok'), findsOneWidget);
  });
}

Future<void> _setupTester(WidgetTester tester) async {
  await tester.pumpWidget(MultiProvider(
    providers: [
      Provider(create: (context) => Router()),
    ],
    child: const App(),
  ));

  await tester.tap(find.widgetWithText(ListTile, 'Alert'));
  await tester.pumpAndSettle();
}
