import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../nasa/cad/cad_route.dart';
import '../../nasa/cad/result/cad_result_route.dart';
import '../../nasa/nasa_route.dart';
import '../settings/settings_route.dart';
import 'home_screen.dart';

part 'home_route.g.dart';

// TODO(hrishikesh-kadam): Add name to other routes?
@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
  name: HomeRoute.path,
  routes: [
    TypedGoRoute<NasaRoute>(
      path: NasaRoute.relativePath,
      routes: [
        TypedGoRoute<CadRoute>(
          path: CadRoute.relativePath,
          routes: [
            TypedGoRoute<CadResultRoute>(
              path: CadResultRoute.relativePath,
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<SettingsRoute>(
      path: SettingsRoute.relativePath,
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String path = '/';
  static const String relativePath = path;
  static const String displayName = 'Home Page';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
