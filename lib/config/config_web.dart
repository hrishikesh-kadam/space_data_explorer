// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';

/// Notes -
/// 1. When HashUrlStrategy is set, deep-link creates problems, because
/// [setUrlStrategy] is No-op in non-web platforms.
///
/// Platform provides correct path but it depends on the Router's implemented
/// logic of [RouteInformationProvider.routerReportsNewRouteInformation], which
/// at the moment is not considered in GoRouter.
void configureUrlStrategy() {
  // TODO(hrishikesh-kadam): File a bug for flutter beta
  // Observed in Flutter 3.12.0 beta, 3.13 stable
  // ignore: prefer_const_constructors
  UrlStrategy urlStrategyToSet = PathUrlStrategy();
  // Requires idempotent call
  if (urlStrategy?.runtimeType != urlStrategyToSet.runtimeType) {
    setUrlStrategy(urlStrategyToSet);
  }
}

BackButton getAppBarBackButton({
  required BuildContext context,
}) {
  return BackButton(
    onPressed: () {
      final html.History history = html.window.history;
      log.finer('getAppBarBackButton -> history.length = ${history.length}');
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
          log.finer('getAppBarBackButton -> serialCount = $serialCount');
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
  );
}
