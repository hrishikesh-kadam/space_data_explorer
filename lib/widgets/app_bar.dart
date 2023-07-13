import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../config/config.dart';
import '../route/home_route.dart';

AppBar getAppBar({
  Key? key,
  required BuildContext context,
  Widget? leading,
  Widget? title,
  Color? backgroundColor,
}) {
  if (leading == null) {
    String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      // Route which doesn't need leading BackButton
      case HomeRoute.relativePath:
        break;
      default:
        leading = getAppBarBackButton(context: context);
    }
  }

  return AppBar(
    key: key,
    leading: leading,
    title: title,
    backgroundColor:
        backgroundColor ?? Theme.of(context).colorScheme.inversePrimary,
  );
}
