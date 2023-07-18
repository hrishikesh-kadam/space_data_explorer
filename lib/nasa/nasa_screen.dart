import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../widgets/app_bar.dart';
import 'cad/cad_route.dart';
import 'nasa_route.dart';

class NasaScreen extends StatelessWidget {
  const NasaScreen({super.key});

  static const Key cadButtonKey = Key('nasa_screen_cad_button');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(NasaRoute.displayName),
      ),
      body: TextButton(
        key: cadButtonKey,
        child: const Text(CadRoute.relativePath),
        onPressed: () async {
          GoRouter.of(context).go(CadRoute.path, extra: getRouteExtra());
        },
      ),
    );
  }
}
