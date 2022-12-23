import 'package:example/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<ProviderContainer> setup(String pageName) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await pumpWidget(
      ProviderScope(
        parent: container,
        child: const App(),
      ),
    );

    await tap(find.widgetWithText(ListTile, pageName));
    await pumpAndSettle();
    return container;
  }

  Future<void> open(String label) async {
    await tap(find.widgetWithText(ListTile, label));
    await pumpAndSettle();
  }

  Future<void> tapBarrier() async {
    await tapAt(Offset.zero);
    await pumpAndSettle();
  }
}
