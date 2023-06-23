import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'helper_non_web.dart' if (dart.library.html) 'helper_web.dart'
    as platform;

bool isAndroid = platform.isAndroid;

List getListOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}

bool isFlutterTest() => platform.isFlutterTest();
