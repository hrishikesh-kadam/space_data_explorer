// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';
import '../pages/home_page.dart';

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
}) {
  return AppBar(
    title: title,
    leading: BackButton(
      onPressed: () {
        final html.History history = html.window.history;
        log.fine('history.length = ${history.length}');
        if (history.length <= 1) {
          GoRouter.of(context).go(HomePage.path);
        } else {
          Map state = history.state;
          if (state.containsKey('serialCount')) {
            final int serialCount = state['serialCount'];
            log.fine('serialCount = $serialCount');
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
  );
}
