import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../extension/go_router.dart';
import '../globals.dart';
import '../route/home/home_route.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher({
    required GoRouter goRouter,
  }) : _goRouter = goRouter {
    _goRouterDelegate = _goRouter.routerDelegate;
  }

  final GoRouter _goRouter;
  late final RouterDelegate _goRouterDelegate;
  final _logger = Logger('$appNamePascalCase.AppBackButtonDispatcher');

  @override
  Future<bool> didPopRoute() async {
    _logger.log(
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? Level.FINEST
            : Level.WARNING,
        'didPopRoute()');
    final Object? extraObject = _goRouterDelegate.currentConfiguration.extra;
    _logger.finer('didPopRoute() -> extraObject = $extraObject');
    Level logLevel = flutterTest ? Level.FINER : Level.SHOUT;
    final String fullPath = _goRouterDelegate.currentConfiguration.fullPath;
    if (fullPath == HomeRoute.uri.path) {
      return _goRouterDelegate.popRoute();
    }
    if (extraObject == null) {
      _goRouter.topOrHomeRoute();
      return true;
    } else if (extraObject is JsonMap) {
      JsonMap extraMap = extraObject;
      if (extraMap.containsKey(isNormalLink)) {
        _goRouter.popOrHomeRoute();
        return true;
      } else {
        _logger.log(logLevel, 'Unusual navigation observed');
        _logger.log(logLevel, 'extra doesn\'t contains isNormalLink key');
        final List routeMatchList = _goRouter.getListOfRouteMatch();
        _logger.log(
            logLevel, 'routeMatchList.length = ${routeMatchList.length}');
        _goRouter.go(HomeRoute.uri.path);
        return true;
      }
    } else {
      _logger.log(logLevel, 'Unusual navigation observed');
      _logger.log(logLevel, 'extra is not a JsonMap');
      final List routeMatchList = _goRouter.getListOfRouteMatch();
      _logger.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
      _goRouter.go(HomeRoute.uri.path);
      return true;
    }
  }
}
