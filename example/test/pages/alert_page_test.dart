import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';

extension on WidgetTester {
  Future<ProviderContainer> setUpAlert() => setup('Alert');
  Future<void> openOkDialog() => open('OK Dialog');
  Future<void> openOkCanPopFalseDialog() => open('OK Dialog (canPop: false)');
  Future<void> openOkBarrierDismissibleFalseDialog() =>
      open('OK Dialog (barrierDismissible: false)');
}

void main() {
  group('OK Dialog', () {
    testWidgets('OK', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkDialog();

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('This is message.'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();

      expect(container.read(resultProvider), OkCancelResult.ok);
    });
    testWidgets('barrier', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkDialog();

      await tester.tapBarrier();

      expect(container.read(resultProvider), OkCancelResult.cancel);
    });

    testWidgets('maybePop', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkDialog();

      final context = tester.element(find.text('Title'));
      await Navigator.of(context).maybePop();
      await tester.pumpAndSettle();

      expect(container.read(resultProvider), OkCancelResult.cancel);
    });
  });

  group('OK Dialog (canPop: false)', () {
    testWidgets('OK', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkCanPopFalseDialog();

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('This is message.'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();

      expect(container.read(resultProvider), OkCancelResult.ok);
    });
    testWidgets('maybePop', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkCanPopFalseDialog();

      final context = tester.element(find.text('Title'));
      await Navigator.of(context).maybePop();
      await tester.pumpAndSettle();

      expect(container.read(resultProvider), isNull);
      expect(find.text('Title'), findsOneWidget);
    });
  });

  group('OK Dialog (barrierDismissible: false)', () {
    testWidgets('OK', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkBarrierDismissibleFalseDialog();

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('This is message.'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();

      expect(container.read(resultProvider), OkCancelResult.ok);
    });
    testWidgets('barrier', (tester) async {
      final container = await tester.setUpAlert();
      await tester.openOkBarrierDismissibleFalseDialog();

      await tester.tapBarrier();

      expect(container.read(resultProvider), isNull);
      expect(find.text('Title'), findsOneWidget);
    });
  });
}
