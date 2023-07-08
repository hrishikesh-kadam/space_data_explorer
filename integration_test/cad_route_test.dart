import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';
import 'nasa_route_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('$CadRoute Integration Test', (WidgetTester tester) async {
    await pumpCadRouteAsNormalLink(tester);
  });
}

Future<void> pumpCadRouteAsInitialLocation(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp(
    initialLocation: CadRoute.path,
  ));
  await tester.pumpAndSettle();
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadRouteAsNormalLink(WidgetTester tester) async {
  await pumpNasaRouteAsNormalLink(tester);
  final cadTextButton = find.widgetWithText(TextButton, CadRoute.relativePath);
  await tester.tap(cadTextButton);
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadScreen), findsOneWidget);
}
