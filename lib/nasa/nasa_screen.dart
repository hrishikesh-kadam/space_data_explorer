import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../widgets/app_bar.dart';
import 'cad/cad_route.dart';
import 'nasa_route.dart';

class NasaScreen extends StatefulWidget {
  const NasaScreen({super.key});

  @override
  State<NasaScreen> createState() => _NasaScreenState();
}

class _NasaScreenState extends State<NasaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(NasaRoute.displayName),
      ),
      body: TextButton(
        child: const Text(CadRoute.relativePath),
        onPressed: () async {
          GoRouter.of(context).go(CadRoute.path, extra: getRouteExtra());
        },
      ),
    );
  }
}
