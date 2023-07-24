import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../space_data_explorer_app.dart';

Future<void> pumpHomeRoute(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpApp(tester, navigatorKey: navigatorKey);
  expect(find.byType(HomeScreen), findsOneWidget);
}
