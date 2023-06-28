import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/nasa/neows_page.dart';
import 'package:space_data_explorer/nasa/neows_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';
import 'nasa_source_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('NeowsPage Integration Test', (WidgetTester tester) async {
    await pumpNeowsPageAsNormalLink(tester);
  });
}

Future<void> pumpNeowsPageAsInitialLocation(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp(
    initialLocation: NeowsPage.path,
  ));
  await tester.pumpAndSettle();
  expect(find.byType(NeowsScreen), findsOneWidget);
}

Future<void> pumpNeowsPageAsNormalLink(WidgetTester tester) async {
  await pumpNasaSourcePageAsNormalLink(tester);
  final neowsTextButton = find.widgetWithText(TextButton, NeowsPage.pageName);
  await tester.tap(neowsTextButton);
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(NeowsScreen), findsOneWidget);
}
