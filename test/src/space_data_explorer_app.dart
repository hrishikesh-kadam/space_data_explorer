import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/space_data_explorer.dart';
import 'config/config.dart';
import 'globals.dart' as globals;

/*
 * TODO(hrishikesh-kadam): Check if the following issue is resolved.
 * https://github.com/flutter/flutter/issues/102469
 * Once that is resolved `rm integration_test/test` 
 */
Future<void> pumpApp(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
  String? initialLocation,
  bool debugShowCheckedModeBanner = true,
}) async {
  configureApp();
  await tester.pumpWidget(SpaceDataExplorerApp(
    navigatorKey: navigatorKey ?? globals.navigatorKey,
    initialLocation: initialLocation,
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
  ));
  await tester.pumpAndSettle();
}
