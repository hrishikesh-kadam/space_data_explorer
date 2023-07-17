// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

// coverage:ignore-file

part of 'nasa_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $nasaRoute,
    ];

RouteBase get $nasaRoute => GoRouteData.$route(
      path: '/nasa',
      name: 'NASA',
      factory: $NasaRouteExtension._fromState,
    );

extension $NasaRouteExtension on NasaRoute {
  static NasaRoute _fromState(GoRouterState state) => const NasaRoute();

  String get location => GoRouteData.$location(
        '/nasa',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
