import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List getLitsOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}
