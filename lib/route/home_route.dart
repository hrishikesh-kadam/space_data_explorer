import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../globals.dart';
import '../nasa/cad/cad_route.dart';
import '../nasa/cad/result/cad_result_route.dart';
import '../nasa/nasa_route.dart';
import '../widgets/app_bar.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: HomeRoute.path,
  name: HomeRoute.path,
  routes: [
    TypedGoRoute<NasaRoute>(
      path: NasaRoute.relativePath,
      routes: [
        TypedGoRoute<CadRoute>(
          path: CadRoute.relativePath,
          routes: [
            TypedGoRoute<CadResultRoute>(
              path: CadResultRoute.relativePath,
            ),
          ],
        ),
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String path = '/';
  static const String relativePath = path;
  static const String displayName = 'Home Page';

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

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
