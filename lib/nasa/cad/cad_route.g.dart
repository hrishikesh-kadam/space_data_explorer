// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

// coverage:ignore-file

part of 'cad_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $cadRoute,
    ];

RouteBase get $cadRoute => GoRouteData.$route(
      path: '/nasa/cad',
      name: 'SBDB Close-Approach Data',
      factory: $CadRouteExtension._fromState,
    );

extension $CadRouteExtension on CadRoute {
  static CadRoute _fromState(GoRouterState state) => const CadRoute();

  String get location => GoRouteData.$location(
        '/nasa/cad',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
