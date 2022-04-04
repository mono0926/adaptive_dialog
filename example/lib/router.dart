import 'package:example/pages/home_page.dart';
import 'package:example/pages/text_input_dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

import 'pages/alert_page.dart';
import 'pages/nested_navigator_page.dart';
import 'pages/sheet_page.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            path: AlertPage.routeName,
            builder: (_, __) => const AlertPage(),
          ),
          GoRoute(
            path: SheetPage.routeName,
            builder: (_, __) => const SheetPage(),
          ),
          GoRoute(
            path: TextInputDialogPage.routeName,
            builder: (_, __) => const TextInputDialogPage(),
          ),
          GoRoute(
            path: NestedNavigatorPage.routeName,
            builder: (_, __) => const NestedNavigatorPage(),
          ),
        ],
      ),
    ],
  ),
);

String pascalCaseFromRouteName(String name) => name.pascalCase;

@immutable
class PageInfo {
  const PageInfo({
    required this.routeName,
  });

  final String routeName;

  static List<PageInfo> get all => [
        AlertPage.routeName,
        SheetPage.routeName,
        TextInputDialogPage.routeName,
        NestedNavigatorPage.routeName,
      ].map((rn) => PageInfo(routeName: rn)).toList();
}
