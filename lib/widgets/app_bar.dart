import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../config/config.dart';
import '../globals.dart';
import '../route/about/about_route.dart';
import '../route/about/license/license_route.dart';
import '../route/home/home_route.dart' hide $SettingsRouteExtension;
import '../route/page_not_found/page_not_found_route.dart';
import '../route/settings/settings_route.dart';

const Key settingsActionKey = Key('settings_action_key');
const Key aboutActionKey = Key('about_action_key');

AppBar getAppBar({
  Key? key,
  required BuildContext context,
  Widget? leading,
  Widget? title,
  List<Widget>? actions,
}) {
  leading ??= getLeadingWidget(context: context);
  actions ??= getDefaultAppBarActions(context: context);
  return AppBar(
    key: key,
    leading: leading,
    title: title,
    actions: actions,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}

SliverAppBar getSliverAppBar({
  Key? key,
  required BuildContext context,
  Widget? leading,
  Widget? title,
  List<Widget>? actions,
  bool floating = false,
  bool snap = false,
}) {
  leading ??= getLeadingWidget(context: context);
  actions ??= getDefaultAppBarActions(context: context);
  return SliverAppBar(
    key: key,
    leading: leading,
    title: title,
    actions: actions,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    floating: floating,
    snap: snap,
  );
}

Widget? getLeadingWidget({
  required BuildContext context,
}) {
  String? location;
  try {
    // throws expected AssertionError for errorBuilder Widgets
    location = GoRouterState.of(context).matchedLocation;
  } catch (_) {}
  switch (location) {
    // Routes which doesn't need leading BackButton
    case HomeRoute.pathSegment:
      return null;
    default:
      return getAppBarBackButton(context: context);
  }
}

List<Widget> getDefaultAppBarActions({required BuildContext context}) {
  String? location;
  try {
    // throws expected AssertionError for errorBuilder Widgets
    location = GoRouterState.of(context).matchedLocation;
  } catch (_) {}
  return <Widget>[
    if (location != null && location == HomeRoute.uri.path)
      getAboutAction(context: context),
    if (location != null &&
        ![
          SettingsRoute.uri.path,
          PageNotFoundRoute.uri.path,
          AboutRoute.uri.path,
          LicenseRoute.uri.path,
        ].contains(location))
      getSettingsAction(context: context),
  ];
}

Widget getSettingsAction({required BuildContext context}) {
  return IconButton(
    key: settingsActionKey,
    icon: const Icon(Icons.settings),
    onPressed: () {
      GoRouter.of(context).push(
        SettingsRoute.uri.path,
        extra: getRouteExtraMap(),
      );
    },
  );
}

Widget getAboutAction({required BuildContext context}) {
  return Link(
    uri: AboutRoute.uri,
    builder: (context, followLink) {
      return IconButton(
        key: aboutActionKey,
        icon: const Icon(Icons.info),
        onPressed: () {
          GoRouter.of(context)
              .go(AboutRoute.uri.path, extra: getRouteExtraMap());
        },
      );
    },
  );
}
