import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../widgets/app_bar.dart';
import '../home/home_route.dart';

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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(SettingsRoute.displayName),
      ),
    );
  }
}
