import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';
import 'home_route_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('$NasaRoute Integration Test', (WidgetTester tester) async {
    await pumpNasaRouteAsNormalLink(tester);
  });
}

Future<void> pumpNasaRouteAsInitialLocation(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp(
    initialLocation: NasaRoute.path,
  ));
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen), findsOneWidget);
}

Future<void> pumpNasaRouteAsNormalLink(WidgetTester tester) async {
  await pumpHomeRoute(tester);
  final nasaTextButton =
      find.widgetWithText(TextButton, NasaRoute.relativePath);
  await tester.tap(nasaTextButton);
  await tester.pumpAndSettle();
  expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(NasaScreen), findsOneWidget);
}
