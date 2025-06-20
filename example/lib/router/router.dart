import 'package:example/pages/home_page.dart';
import 'package:example/pages/text_input_dialog_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

import '../pages/alert_page.dart';
import '../pages/nested_navigator_page.dart';
import '../pages/sheet_page.dart';

part 'router.g.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  ),
);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<AlertRoute>(path: 'alert'),
    TypedGoRoute<SheetRoute>(path: 'sheet'),
    TypedGoRoute<TextInputDialogRoute>(path: 'text-input'),
    TypedGoRoute<NestedNavigatorRoute>(path: 'nested-navigator'),
  ],
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class AlertRoute extends GoRouteData with _$AlertRoute {
  const AlertRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const AlertPage();
}

class NestedNavigatorRoute extends GoRouteData with _$NestedNavigatorRoute {
  const NestedNavigatorRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NestedNavigatorPage();
}

class SheetRoute extends GoRouteData with _$SheetRoute {
  const SheetRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SheetPage();
}

class TextInputDialogRoute extends GoRouteData with _$TextInputDialogRoute {
  const TextInputDialogRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TextInputDialogPage();
}

String pascalCaseFromRouteName(String name) => name.pascalCase;
String pascalCaseFromRouteUri(Uri uri) =>
    pascalCaseFromRouteName(uri.toString());

List<String> get allRouteLocations => [
      const AlertRoute().location,
      const SheetRoute().location,
      const TextInputDialogRoute().location,
      const NestedNavigatorRoute().location,
    ];
