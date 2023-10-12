import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../constants/labels.dart';
import '../../nasa/cad/cad_route.dart';
import '../../nasa/cad_result/cad_result_route.dart';
import '../../nasa/route/nasa_route.dart';
import '../about/about_route.dart';
import '../about/license/license_route.dart';
import '../settings/settings_route.dart';
import 'home_screen.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.pathSegment,
  name: HomeRoute.displayName,
  routes: [
    TypedGoRoute<NasaRoute>(
      path: NasaRoute.pathSegment,
      name: NasaRoute.displayName,
      routes: [
        TypedGoRoute<CadRoute>(
          path: CadRoute.pathSegment,
          name: CadRoute.displayName,
          routes: [
            TypedGoRoute<CadResultRoute>(
              path: CadResultRoute.pathSegment,
              name: CadResultRoute.displayName,
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<SettingsRoute>(
      path: SettingsRoute.pathSegment,
      name: SettingsRoute.displayName,
    ),
    TypedGoRoute<AboutRoute>(
      path: AboutRoute.pathSegment,
      name: AboutRoute.displayName,
      routes: [
        TypedGoRoute<LicenseRoute>(
          path: LicenseRoute.pathSegment,
          name: LicenseRoute.displayName,
        )
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String pathSegment = '/';
  static final Uri uri = Uri(path: pathSegment);
  static const String displayName = Labels.spaceDataExplorer;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context);
    return HomeScreen(
      title: l10n.spaceDataExplorer,
      l10n: l10n,
    );
  }
}
