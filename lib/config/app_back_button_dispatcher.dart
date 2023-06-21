import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../globals.dart';
import '../pages/home_page.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher({
    required GoRouter goRouter,
  }) : _goRouter = goRouter {
    _goRouterDelegate = _goRouter.routerDelegate;
  }

  final GoRouter _goRouter;
  late final RouterDelegate _goRouterDelegate;

  @override
  Future<bool> didPopRoute() async {
    log.fine('-> Back button pressed');
    final Object? extraObject = _goRouterDelegate.currentConfiguration.extra;
    log.fine('-> Back button pressed -> extraObject = $extraObject');
    Level logLevel = flutterTest ? Level.INFO : Level.SEVERE;
    if (extraObject == null) {
      final String fullPath = _goRouterDelegate.currentConfiguration.fullPath;
      if (fullPath == HomePage.path) {
        return _goRouterDelegate.popRoute();
      } else {
        while (_goRouter.canPop()) {
          _goRouter.pop();
        }
      }
    } else if (extraObject is Map) {
      Map extraMap = extraObject;
      if (extraMap.containsKey(isNormalLink)) {
        return _goRouterDelegate.popRoute();
      } else {
        log.log(logLevel, 'Unusual navigation observed');
        log.log(logLevel, 'extra doesn\'t contains isNormalLink key');
        final List routeMatchList =
            _goRouter.routerDelegate.currentConfiguration.matches;
        log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
        _goRouter.go(HomePage.path);
      }
    } else {
      log.log(logLevel, 'Unusual navigation observed');
      log.log(logLevel, 'extra is not a Map');
      final List routeMatchList =
          _goRouter.routerDelegate.currentConfiguration.matches;
      log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
      _goRouter.go(HomePage.path);
    }
    return true;
  }
}
