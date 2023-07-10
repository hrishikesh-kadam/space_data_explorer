import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../deferred_loading/deferred_loading.dart';
import '../nasa_route.dart';
import 'cad_screen.dart' deferred as cad_screen;

part 'cad_route.g.dart';

@TypedGoRoute<CadRoute>(
  path: CadRoute.path,
  name: CadRoute.displayName,
)
class CadRoute extends GoRouteData {
  const CadRoute();

  static const String relativePath = 'cad';
  static const String displayName = 'SBDB Close-Approach Data';
  static const String path = '${NasaRoute.path}/$relativePath';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      cad_screen.loadLibrary,
      () => cad_screen.CadScreen(),
      placeholder: const DeferredPlaceholderWidget(
        name: CadRoute.displayName,
      ),
    );
  }
}
