import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../home/home_route.dart';
import 'settings_screen.dart';

part 'settings_route.g.dart';

@TypedGoRoute<SettingsRoute>(
  path: SettingsRoute.path,
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  static const String relativePath = 'settings';
  static const String path = '${HomeRoute.path}settings';
  static const String displayName = 'Settings Page';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
