import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'utility_non_web.dart' if (dart.library.html) 'utility_web.dart'
    as platform;

// TODO(hrishikesh-kadam): Separate out helpers and utility

bool isAndroid = platform.isAndroid;

List getListOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}

bool isFlutterTest() => platform.isFlutterTest();
