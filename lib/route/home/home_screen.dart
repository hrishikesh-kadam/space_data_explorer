import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../nasa/nasa_route.dart';
import '../../widgets/app_bar.dart';
import 'home_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Key nasaButtonKey = Key('home_screen_nasa_button');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(HomeRoute.displayName),
      ),
      body: TextButton(
        key: nasaButtonKey,
        child: const Text(NasaRoute.relativePath),
        onPressed: () async {
          GoRouter.of(context).go(NasaRoute.path, extra: getRouteExtra());
        },
      ),
    );
  }
}
