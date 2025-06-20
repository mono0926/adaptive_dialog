// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: _$HomeRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'alert',
          factory: _$AlertRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'sheet',
          factory: _$SheetRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'text-input',
          factory: _$TextInputDialogRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'nested-navigator',
          factory: _$NestedNavigatorRoute._fromState,
        ),
      ],
    );

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AlertRoute on GoRouteData {
  static AlertRoute _fromState(GoRouterState state) => const AlertRoute();

  @override
  String get location => GoRouteData.$location(
        '/alert',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SheetRoute on GoRouteData {
  static SheetRoute _fromState(GoRouterState state) => const SheetRoute();

  @override
  String get location => GoRouteData.$location(
        '/sheet',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TextInputDialogRoute on GoRouteData {
  static TextInputDialogRoute _fromState(GoRouterState state) =>
      const TextInputDialogRoute();

  @override
  String get location => GoRouteData.$location(
        '/text-input',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$NestedNavigatorRoute on GoRouteData {
  static NestedNavigatorRoute _fromState(GoRouterState state) =>
      const NestedNavigatorRoute();

  @override
  String get location => GoRouteData.$location(
        '/nested-navigator',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
