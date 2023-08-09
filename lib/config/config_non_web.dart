import 'dart:io';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../globals.dart';
import '../helper/helper.dart';
import '../route/home/home_route.dart';

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
      } else if (extraObject is JsonMap) {
        JsonMap extraMap = extraObject;
        if (extraMap.containsKey(isNormalLink)) {
          GoRouter.of(context).pop();
        } else {
          log.log(
              logLevel, 'getAppBarBackButton -> Unusual navigation observed');
          log.log(logLevel, 'extra doesn\'t contains isNormalLink key');
          final routeMatchList = getListOfRouteMatch(context);
          log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
          GoRouter.of(context).go(HomeRoute.path);
        }
      } else {
        log.log(logLevel, 'getAppBarBackButton -> Unusual navigation observed');
        log.log(logLevel, 'extra is not a JsonMap');
        final routeMatchList = getListOfRouteMatch(context);
        log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
        GoRouter.of(context).go(HomeRoute.path);
      }
    },
  );
}

bool isKeyboardVisibilitySupported() {
  return Platform.isAndroid || Platform.isIOS;
}
