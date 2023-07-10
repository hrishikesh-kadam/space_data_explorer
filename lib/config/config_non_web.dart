import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../globals.dart';
import '../helper/helper.dart';
import '../route/home_route.dart';
import '../typedef/typedef.dart';

void configureUrlStrategy() {
  // No-op in non-web platforms.
}

BackButton getAppBarBackButton({
  required BuildContext context,
}) {
  return BackButton(
    onPressed: () {
      final Object? extraObject = GoRouterState.of(context).extra;
      Level logLevel = flutterTest ? Level.FINER : Level.SHOUT;
      if (extraObject == null) {
        while (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        }
      } else if (extraObject is RouteExtraMap) {
        RouteExtraMap pageExtraMap = extraObject;
        if (pageExtraMap.containsKey(isNormalLink)) {
          GoRouter.of(context).pop();
        } else {
          log.log(logLevel, 'Unusual navigation observed');
          log.log(logLevel, 'extra doesn\'t contains isNormalLink key');
          final routeMatchList = getListOfRouteMatch(context);
          log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
          GoRouter.of(context).go(HomeRoute.path);
        }
      } else {
        log.log(logLevel, 'Unusual navigation observed');
        log.log(logLevel, 'extra is not a Map');
        final routeMatchList = getListOfRouteMatch(context);
        log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
        GoRouter.of(context).go(HomeRoute.path);
      }
    },
  );
}
