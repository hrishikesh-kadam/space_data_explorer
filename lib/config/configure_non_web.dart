import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../globals.dart';
import '../pages/home_page.dart';
import '../utility/utility.dart';

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
}) {
  return AppBar(
    title: title,
    leading: BackButton(
      onPressed: () {
        final extraObject = GoRouterState.of(context).extra;
        Level logLevel = isFLutterTest() ? Level.FINE : Level.SEVERE;
        if (extraObject == null) {
          GoRouter.of(context).go(HomePage.path);
        } else if (extraObject is Map) {
          Map extraMap = extraObject;
          if (extraMap.containsKey(isNormalLink)) {
            GoRouter.of(context).pop();
          } else {
            log.log(logLevel, 'Unusual navigation observed');
            log.log(logLevel, 'extra doesn\'t contains isNormalLink key');
            log.log(logLevel, getLitsOfRouteMatch(context));
            GoRouter.of(context).go(HomePage.path);
          }
        } else {
          log.log(logLevel, 'Unusual navigation observed');
          log.log(logLevel, 'extra is not a Map');
          log.log(logLevel, getLitsOfRouteMatch(context));
          GoRouter.of(context).go(HomePage.path);
        }
      },
    ),
  );
}

bool isFLutterTest() => Platform.environment.containsKey('FLUTTER_TEST');
