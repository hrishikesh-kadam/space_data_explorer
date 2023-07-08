import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../deferred_loading/deferred_widget.dart';
import '../../../typedef/typedef.dart';
import '../cad_route.dart';
import 'cad_result_screen.dart' deferred as cad_result_screen;

part 'cad_result_route.g.dart';

@TypedGoRoute<CadResultRoute>(
  path: CadResultRoute.path,
  name: CadResultRoute.displayName,
)
class CadResultRoute extends GoRouteData {
  const CadResultRoute({
    this.$extra,
  });

  final RouteExtraMap? $extra;

  static const String relativePath = 'result';
  static const String displayName = 'SBDB Close-Approach Data Result';
  static const String path = '${CadRoute.path}/$relativePath';

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (state.extra is RouteExtraMap) {
      final RouteExtraMap extra = state.extra as RouteExtraMap;
      if (extra.containsKey('$SbdbCadBody') &&
          extra['$SbdbCadBody'] is SbdbCadBody) {
        return null;
      }
    }
    return CadRoute.path;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      cad_result_screen.loadLibrary,
      () => cad_result_screen.CadResultScreen(
        sbdbCadBody: $extra!['$SbdbCadBody'],
      ),
      placeholder: const DeferredLoadingPlaceholder(
        name: CadResultRoute.displayName,
      ),
    );
  }
}
