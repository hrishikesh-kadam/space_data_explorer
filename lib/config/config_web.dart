// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';

/// Notes -
/// 1. When HashUrlStrategy is set, deep-link creates problems, because
/// [setUrlStrategy] is No-op in non-web platforms.
/// Platform provides correct path but it depends on the Router's implemented
/// logic of [RouteInformationProvider.routerReportsNewRouteInformation], which
/// at the moment is not considered in GoRouter.
void configureUrlStrategy() {
  // TODO(hrishikesh-kadam): File a bug for flutter beta
  // Observed in Flutter 3.12.0 beta
  // ignore: prefer_const_constructors
  UrlStrategy urlStrategyToSet = PathUrlStrategy();
  // TODO(hrishikesh-kadam): File a request for idempotent calls for
  // setUrlStrategy() method.
  if (urlStrategy?.runtimeType != urlStrategyToSet.runtimeType) {
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
        log.finer('history.length = ${history.length}');
        if (history.length <= 1) {
          while (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
        } else {
          Map? state = history.state;
          if (state == null) {
            while (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            }
          } else if (state.containsKey('serialCount')) {
            final int serialCount = state['serialCount'];
            log.finer('serialCount = $serialCount');
            if (serialCount <= 0) {
              while (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              }
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