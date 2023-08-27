import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../nasa/cad/cad_route.dart';
import '../../nasa/cad_result/cad_result_route.dart';
import '../../nasa/route/nasa_route.dart';
import '../settings/settings_route.dart';
import 'home_screen.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
  name: HomeRoute.displayName,
  routes: [
    TypedGoRoute<NasaRoute>(
      path: NasaRoute.routeName,
      name: NasaRoute.displayName,
      routes: [
        TypedGoRoute<CadRoute>(
          path: CadRoute.routeName,
          name: CadRoute.displayName,
          routes: [
            TypedGoRoute<CadResultRoute>(
              path: CadResultRoute.routeName,
              name: CadResultRoute.displayName,
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<SettingsRoute>(
      path: SettingsRoute.routeName,
      name: SettingsRoute.displayName,
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String path = '/';
  static const String routeName = path;
  static const String displayName = 'Home Page';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
