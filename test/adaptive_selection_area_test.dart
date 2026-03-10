// ignore_for_file: lines_longer_than_80_chars

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/helper/adaptive_selection_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveSelectionArea', () {
    testWidgets('selectionMode: none - SelectionArea is not present', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaptiveSelectionArea(
              mode: AdaptiveSelectionMode.none,
              child: Text('Hello'),
            ),
          ),
        ),
      );

      expect(find.byType(SelectionArea), findsNothing);
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('selectionMode: all - SelectionArea is always present', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaptiveSelectionArea(
              mode: AdaptiveSelectionMode.all,
              child: Text('Hello'),
            ),
          ),
        ),
      );

      expect(find.byType(SelectionArea), findsOneWidget);
    });

    testWidgets(
      'selectionMode: desktop - SelectionArea presence depends on platform',
      (tester) async {
        for (final platform in TargetPlatform.values) {
          debugDefaultTargetPlatformOverride = platform;

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: AdaptiveSelectionArea(
                  mode: AdaptiveSelectionMode.desktop,
                  child: Text('Hello'),
                ),
              ),
            ),
          );

          final isDesktop = {
            TargetPlatform.macOS,
            TargetPlatform.windows,
            TargetPlatform.linux,
          }.contains(platform);

          if (isDesktop) {
            expect(
              find.byType(SelectionArea),
              findsOneWidget,
              reason: 'Should be selectable on $platform',
            );
          } else {
            expect(
              find.byType(SelectionArea),
              findsNothing,
              reason: 'Should not be selectable on $platform',
            );
          }
        }
        debugDefaultTargetPlatformOverride = null;
      },
    );

    testWidgets(
      'selectionMode: null (default) - uses AdaptiveDialog.instance.selectionMode',
      (tester) async {
        // Need to runAsync because AdaptiveDialog instance initialization has a Future
        await tester.runAsync(() async {
          AdaptiveDialog.instance.updateConfiguration(
            selectionMode: AdaptiveSelectionMode.all,
          );
        });

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AdaptiveSelectionArea(
                child: Text('Hello'),
              ),
            ),
          ),
        );

        expect(find.byType(SelectionArea), findsOneWidget);

        // Reset configuration
        await tester.runAsync(() async {
          AdaptiveDialog.instance.updateConfiguration(
            selectionMode: AdaptiveSelectionMode.desktop,
          );
        });
      },
    );
  });

  group('Dialog Selection Tests', () {
    testWidgets(
      'showOkAlertDialog includes SelectionArea when selectionMode is all',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => showOkAlertDialog(
                    context: context,
                    title: 'Title',
                    message: 'Message',
                    selectionMode: AdaptiveSelectionMode.all,
                  ),
                  child: const Text('Show'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pumpAndSettle();

        expect(find.byType(SelectionArea), findsAtLeastNWidgets(1));
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      },
    );
  });
}
