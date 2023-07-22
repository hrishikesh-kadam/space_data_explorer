import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/app_bar.dart';
import '../../space_data_explorer_app.dart';
import '../home/home_route.dart';

Future<void> pumpSettingsRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: SettingsRoute.path);
  expect(find.byType(SettingsScreen), findsOneWidget);
  expect(find.byKey(settingsButtonKey), findsNothing);
}

Future<void> pumpSettingsRouteAsNormalLink(WidgetTester tester) async {
  await pumpHomeRoute(tester);
  await tapSettingsButton(tester);
  expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(SettingsScreen), findsOneWidget);
  expect(find.byKey(settingsButtonKey), findsNothing);
}

Future<void> tapSettingsButton(WidgetTester tester) async {
  await tester.tap(find.byKey(settingsButtonKey));
  await tester.pumpAndSettle();
}
