import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/nasa/cad_page.dart';
import 'package:space_data_explorer/nasa/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';
import 'nasa_source_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CadPage Integration Test', (WidgetTester tester) async {
    await pumpCadPageAsNormalLink(tester);
  });
}

Future<void> pumpCadPageAsInitialLocation(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp(
    initialLocation: CadPage.path,
  ));
  await tester.pumpAndSettle();
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadPageAsNormalLink(WidgetTester tester) async {
  await pumpNasaSourcePageAsNormalLink(tester);
  final cadTextButton = find.widgetWithText(TextButton, CadPage.pageName);
  await tester.tap(cadTextButton);
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadScreen), findsOneWidget);
}
