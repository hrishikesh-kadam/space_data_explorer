import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/app_bar.dart';
import '../../space_data_explorer_app.dart';
import '../home/home_route.dart';

final settingsActionFinder = find.byKey(settingsActionKey);
final settingsListViewFinder = find.byKey(SettingsScreen.listViewKey);

Future<void> pumpSettingsRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: SettingsRoute.uri.path);
}

Future<void> pumpSettingsRouteAsNormalLink(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpHomeRoute(tester, navigatorKey: navigatorKey);
  await tapSettingsAction(tester);
}

Future<void> tapSettingsAction(WidgetTester tester) async {
  await tester.tap(settingsActionFinder);
  await tester.pumpAndSettle();
}

Future<void> ensureTileVisible(WidgetTester tester, Finder tileFinder) async {
  await tester.dragUntilVisible(
    tileFinder,
    settingsListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}
