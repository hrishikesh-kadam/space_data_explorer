import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/nasa_source_page.dart';
import 'pages/neows_page.dart';

class SpaceDataExplorerApp extends StatelessWidget {
  SpaceDataExplorerApp({
    super.key,
    GlobalKey<NavigatorState>? navigatorKey,
    this.initialLocation = HomePage.path,
    this.debugShowCheckedModeBanner = true,
  }) {
    _router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: NasaSourcePage.pageName,
              pageBuilder: (context, state) => const NasaSourcePage(),
              routes: [
                GoRoute(
                  path: NeowsPage.pageName,
                  pageBuilder: (context, state) => const NeowsPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  final String initialLocation;
  late final GoRouter _router;
  final bool debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
    );
  }
}
