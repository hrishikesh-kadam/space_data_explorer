// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'cad_result_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $cadResultRoute,
    ];

RouteBase get $cadResultRoute => GoRouteData.$route(
      path: '/nasa/cad/result',
      name: 'SBDB Close-Approach Data Result',
      factory: $CadResultRouteExtension._fromState,
    );

extension $CadResultRouteExtension on CadResultRoute {
  static CadResultRoute _fromState(GoRouterState state) =>
      const CadResultRoute();

  String get location => GoRouteData.$location(
        '/nasa/cad/result',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
