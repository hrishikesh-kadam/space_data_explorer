import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../deferred_loading/deferred_loading.dart';
import '../../typedef/typedef.dart';
import '../nasa_route.dart';
import 'cad_screen.dart' deferred as cad_screen;

part 'cad_route.g.dart';

@TypedGoRoute<CadRoute>(
  path: CadRoute.path,
  name: CadRoute.displayName,
)
class CadRoute extends GoRouteData {
  const CadRoute({
    this.$extra,
  });

  final RouteExtraMap? $extra;

  static const String relativePath = 'cad';
  static const String path = '${NasaRoute.path}/$relativePath';
  static const String displayName = 'SBDB Close-Approach Data';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      cad_screen.loadLibrary,
      () => cad_screen.CadScreen(
        l10n: AppLocalizations.of(context),
        routeExtraMap: $extra,
      ),
      placeholder: const DeferredPlaceholderWidget(
        name: CadRoute.displayName,
      ),
    );
  }
}
