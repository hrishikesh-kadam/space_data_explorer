// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';
import '../pages/home_page.dart';

/// Notes -
/// 1. When HashUrlStrategy is set, deep-link creates problems, because
/// [setUrlStrategy] is No-op in non-web platforms.
/// Platform provides correct path but it depends on the Router's implemented
/// logic of [RouteInformationProvider.routerReportsNewRouteInformation], which
/// at the moment is not considered in GoRouter.
void configureUrlStrategy() {
  UrlStrategy urlStrategyToSet = PathUrlStrategy();
  // TODO(hrishikesh-kadam): File a request for idempotent calls for
  // setUrlStrategy() method.
  if (urlStrategy != null &&
      urlStrategy.runtimeType != urlStrategyToSet.runtimeType) {
    setUrlStrategy(urlStrategyToSet);
  }
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
        final html.History history = html.window.history;
        log.info('history.length = ${history.length}');
        if (history.length <= 1) {
          GoRouter.of(context).go(HomePage.path);
        } else {
          Map state = history.state;
          if (state.containsKey('serialCount')) {
            final int serialCount = state['serialCount'];
            log.info('serialCount = $serialCount');
            if (serialCount == 0) {
              GoRouter.of(context).go(HomePage.path);
            } else {
              history.back();
            }
          } else {
            history.back();
          }
        }
      },
    ),
    bottom: bottom,
  );
}
