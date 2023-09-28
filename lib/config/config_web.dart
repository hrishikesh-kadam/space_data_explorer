// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

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
