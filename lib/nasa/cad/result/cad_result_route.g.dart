// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

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
  static CadResultRoute _fromState(GoRouterState state) => CadResultRoute(
        $extra: state.extra as Map<String, dynamic>?,
      );

  String get location => GoRouteData.$location(
        '/nasa/cad/result',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
