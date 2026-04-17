import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/helper/adaptive_selection_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const channel = MethodChannel('io.material.plugins/dynamic_color');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (methodCall) async => null,
    );

    // Initialize AdaptiveDialog.instance and wait for internal Future
    // to complete
    AdaptiveDialog.instance;
    await Future<void>.delayed(Duration.zero);
  });

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

    test('isSelectable logic', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(AdaptiveSelectionMode.desktop.isSelectable, isFalse);

      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(AdaptiveSelectionMode.desktop.isSelectable, isTrue);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
      'selectionMode: null (default) - '
      'uses AdaptiveDialog.instance.selectionMode',
      (tester) async {
        final originalMode = AdaptiveDialog.instance.selectionMode;
        AdaptiveDialog.instance.updateConfiguration(
          selectionMode: AdaptiveSelectionMode.all,
        );

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

        AdaptiveDialog.instance.updateConfiguration(
          selectionMode: originalMode,
        );
      },
    );
  });

  group('Dialog Selection Tests', () {
    testWidgets(
      'showOkAlertDialog includes SelectionArea when selectionMode is all',
      (tester) async {
        await tester.runAsync(() async {
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
          // Wait for dialog animation
          for (var i = 0; i < 10; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }

          expect(find.byType(SelectionArea), findsAtLeastNWidgets(1));
          expect(find.text('Title'), findsOneWidget);
          expect(find.text('Message'), findsOneWidget);

          await tester.tap(find.text('OK'));
          // Wait for closing animation
          for (var i = 0; i < 10; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
        });
      },
    );
  });
}
