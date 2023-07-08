// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'home_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      name: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'nasa',
          factory: $NasaRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'cad',
              factory: $CadRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'result',
                  factory: $CadResultRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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
