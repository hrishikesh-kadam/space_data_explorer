import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../deferred_loading/deferred_loading.dart';
import '../../route/home/home_route.dart';
import 'nasa_screen.dart' deferred as nasa_screen;

part 'nasa_route.g.dart';

@TypedGoRoute<NasaRoute>(
  path: NasaRoute.path,
  name: NasaRoute.displayName,
)
class NasaRoute extends GoRouteData {
  const NasaRoute();

  static const String relativePath = 'nasa';
  static const String path = '${HomeRoute.path}$relativePath';
  static const String displayName = 'NASA';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      nasa_screen.loadLibrary,
      () => nasa_screen.NasaScreen(),
      placeholder: const DeferredPlaceholderWidget(
        name: displayName,
      ),
    );
  }
}
