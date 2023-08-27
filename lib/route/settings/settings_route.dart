import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../deferred_loading/deferred_loading.dart';
import '../home/home_route.dart';
import 'settings_screen.dart' deferred as settings_screen;

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  static const String routeName = 'settings';
  static const String path = '${HomeRoute.path}$routeName';
  static const String displayName = 'Settings Page';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeferredWidget(
      settings_screen.loadLibrary,
      () => settings_screen.SettingsScreen(
        l10n: AppLocalizations.of(context),
      ),
      placeholder: const DeferredPlaceholderWidget(
        name: SettingsRoute.displayName,
      ),
    );
  }
}
