import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../deferred_loading/deferred_widget.dart';
import '../cad_route.dart';
import 'cad_result_screen.dart' deferred as cad_result_screen;

part 'cad_result_route.g.dart';

@TypedGoRoute<CadResultRoute>(
  path: CadResultRoute.path,
  name: CadResultRoute.displayName,
)
class CadResultRoute extends GoRouteData {
  const CadResultRoute();

  static const String relativePath = 'result';
  static const String displayName = 'SBDB Close-Approach Data Result';
  static const String path = '${CadRoute.path}/$relativePath';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      cad_result_screen.loadLibrary,
      () => cad_result_screen.CadResultScreen(),
      placeholder: const DeferredLoadingPlaceholder(
        name: CadResultRoute.displayName,
      ),
    );
  }
}
