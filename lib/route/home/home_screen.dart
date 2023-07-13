import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../nasa/nasa_route.dart';
import '../../widgets/app_bar.dart';
import 'home_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(HomeRoute.displayName),
      ),
      body: TextButton(
        child: const Text(NasaRoute.relativePath),
        onPressed: () async {
          GoRouter.of(context).go(NasaRoute.path, extra: getRouteExtra());
        },
      ),
    );
  }
}
