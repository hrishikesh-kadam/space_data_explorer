// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

// coverage:ignore-file

part of 'page_not_found_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $pageNotFoundRoute,
    ];

RouteBase get $pageNotFoundRoute => GoRouteData.$route(
      path: '/page-not-found',
      name: 'Page Not Found',
      factory: $PageNotFoundRouteExtension._fromState,
    );

extension $PageNotFoundRouteExtension on PageNotFoundRoute {
  static PageNotFoundRoute _fromState(GoRouterState state) => PageNotFoundRoute(
        $extra: state.extra as Map<String, dynamic>?,
      );

  String get location => GoRouteData.$location(
        '/page-not-found',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
