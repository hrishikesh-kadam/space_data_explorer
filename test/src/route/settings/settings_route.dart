import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/app_bar.dart';
import '../../space_data_explorer_app.dart';
import '../home/home_route.dart';

final settingsButtonFinder = find.byKey(settingsButtonKey);
final settingsListViewFinder = find.byKey(SettingsScreen.listViewKey);

Future<void> pumpSettingsRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: SettingsRoute.path);
}

Future<void> pumpSettingsRouteAsNormalLink(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpHomeRoute(tester, navigatorKey: navigatorKey);
  await tapSettingsButton(tester);
}

Future<void> tapSettingsButton(WidgetTester tester) async {
  await tester.tap(settingsButtonFinder);
  await tester.pumpAndSettle();
}
