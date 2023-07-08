import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'config/app_back_button_dispatcher.dart';
import 'route/home_route.dart';

class SpaceDataExplorerApp extends StatelessWidget {
  SpaceDataExplorerApp({
    super.key,
    GlobalKey<NavigatorState>? navigatorKey,
    String? initialLocation,
    bool debugShowCheckedModeBanner = true,
  })  : _debugShowCheckedModeBanner = debugShowCheckedModeBanner,
        _initialLocation = initialLocation {
    _goRouter = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: _initialLocation,
      routes: [
        $homeRoute,
      ],
    );
  }

  final String? _initialLocation;
  late final GoRouter _goRouter;
  final bool _debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _goRouter.routeInformationProvider,
      routeInformationParser: _goRouter.routeInformationParser,
      routerDelegate: _goRouter.routerDelegate,
      backButtonDispatcher: AppBackButtonDispatcher(goRouter: _goRouter),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
    );
  }
}
