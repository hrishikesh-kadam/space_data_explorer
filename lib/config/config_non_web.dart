import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../globals.dart';
import '../helper/helper.dart';
import '../pages/home_page.dart';

void configureUrlStrategy() {
  // No-op in non-web platforms.
}

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    title: title,
    leading: BackButton(
      onPressed: () {
        final Object? extraObject = GoRouterState.of(context).extra;
        Level logLevel = flutterTest ? Level.FINER : Level.SEVERE;
        if (extraObject == null) {
          while (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
        } else if (extraObject is Map) {
          Map extraMap = extraObject;
          if (extraMap.containsKey(isNormalLink)) {
            GoRouter.of(context).pop();
          } else {
            log.log(logLevel, 'Unusual navigation observed');
            log.log(logLevel, 'extra doesn\'t contains isNormalLink key');
            final routeMatchList = getListOfRouteMatch(context);
            log.log(
                logLevel, 'routeMatchList.length = ${routeMatchList.length}');
            GoRouter.of(context).go(HomePage.path);
          }
        } else {
          log.log(logLevel, 'Unusual navigation observed');
          log.log(logLevel, 'extra is not a Map');
          final routeMatchList = getListOfRouteMatch(context);
          log.log(logLevel, 'routeMatchList.length = ${routeMatchList.length}');
          GoRouter.of(context).go(HomePage.path);
        }
      },
    ),
    bottom: bottom,
  );
}