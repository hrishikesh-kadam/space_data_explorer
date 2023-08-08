import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../space_data_explorer_app.dart';

Future<void> pumpHomeRoute(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpApp(tester, navigatorKey: navigatorKey);
}
