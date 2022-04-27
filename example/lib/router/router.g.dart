// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'alert',
          factory: $AlertRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'sheet',
          factory: $SheetRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'text-input',
          factory: $TextInputDialogRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'nested-navigator',
          factory: $NestedNavigatorRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $AlertRouteExtension on AlertRoute {
  static AlertRoute _fromState(GoRouterState state) => const AlertRoute();

  String get location => GoRouteData.$location(
        '/alert',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $SheetRouteExtension on SheetRoute {
  static SheetRoute _fromState(GoRouterState state) => const SheetRoute();

  String get location => GoRouteData.$location(
        '/sheet',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $TextInputDialogRouteExtension on TextInputDialogRoute {
  static TextInputDialogRoute _fromState(GoRouterState state) =>
      const TextInputDialogRoute();

  String get location => GoRouteData.$location(
        '/text-input',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}

extension $NestedNavigatorRouteExtension on NestedNavigatorRoute {
  static NestedNavigatorRoute _fromState(GoRouterState state) =>
      const NestedNavigatorRoute();

  String get location => GoRouteData.$location(
        '/nested-navigator',
      );

  void go(BuildContext buildContext) => buildContext.go(location, extra: this);
}
