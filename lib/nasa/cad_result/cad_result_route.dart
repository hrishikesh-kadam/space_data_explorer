import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../deferred_loading/deferred_loading.dart';
import '../../../typedef/typedef.dart';
import '../../constants/constants.dart';
import '../cad/cad_route.dart';
import 'cad_result_screen.dart' deferred as cad_result_screen;

part 'cad_result_route.g.dart';

@TypedGoRoute<CadResultRoute>(
  path: CadResultRoute.path,
  name: CadResultRoute.displayName,
)
class CadResultRoute extends GoRouteData {
  CadResultRoute({
    this.$extra,
  });

  final RouteExtraMap? $extra;
  final _log = Logger('$appNamePascalCase.CadResultRoute');

  static const String relativePath = 'result';
  static const String path = '${CadRoute.path}/$relativePath';
  static const String displayName = 'SBDB Close-Approach Data Result';

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    _log.debug('redirect');
    if ($extra != null) {
      final RouteExtraMap extra = $extra!;
      if (extra.containsKey('$SbdbCadBody')) {
        if (extra['$SbdbCadBody'] is SbdbCadBody) {
          _log.debug('redirect -> extra[SbdbCadBody] is SbdbCadBody');
          return null;
        } else if (extra['$SbdbCadBody'] is JsonMap) {
          _log.debug('redirect -> extra[SbdbCadBody] is JsonMap');
          extra['$SbdbCadBody'] = SbdbCadBody.fromJson(extra['$SbdbCadBody']);
          return null;
        }
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
      placeholder: const DeferredPlaceholderWidget(
        name: CadResultRoute.displayName,
      ),
    );
  }
}
