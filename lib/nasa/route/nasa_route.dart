import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../constants/labels.dart';
import '../../deferred_loading/deferred_loading.dart';
import 'nasa_screen.dart' deferred as nasa_screen;

class NasaRoute extends GoRouteData {
  const NasaRoute();

  static const String routeName = 'nasa';
  static const String path = '/$routeName';
  static const String displayName = Labels.nasa;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    const title = displayName;
    return DeferredWidget(
      nasa_screen.loadLibrary,
      () => nasa_screen.NasaScreen(
        title: title,
        l10n: AppLocalizations.of(context),
      ),
      placeholder: const DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
