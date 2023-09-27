import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import '../../constants/labels.dart';
import '../../deferred_loading/deferred_loading.dart';
import '../route/nasa_route.dart';
import 'cad_screen.dart' deferred as cad_screen;

class CadRoute extends GoRouteData {
  const CadRoute({
    this.$extra,
  });

  final JsonMap? $extra;

  static const String routeName = 'cad';
  static const String path = '${NasaRoute.path}/$routeName';
  static const String displayName = Labels.sbdbCloseApproachData;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.cadRouteName;
    return DeferredWidget(
      cad_screen.loadLibrary,
      () => cad_screen.CadScreen(
        title: title,
        l10n: l10n,
        routeExtraMap: $extra,
      ),
      placeholder: DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
