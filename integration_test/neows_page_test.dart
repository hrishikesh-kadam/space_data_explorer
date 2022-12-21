import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source_page.dart';
import 'package:space_data_explorer/pages/neows_page.dart';

import 'nasa_source_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('NeowsPage Integration Test', (WidgetTester tester) async {
    await neowsPageIntegrationTest(tester);
  });
}

Future<void> neowsPageIntegrationTest(WidgetTester tester) async {
  await nasaSourcePageIntegrationTest(tester);
  final neowsTextButton = find.widgetWithText(TextButton, NeowsPage.pageName);
  await tester.tap(neowsTextButton);
  await tester.pumpAndSettle();
  expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(NasaSourceScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(NeowsScreen), findsOneWidget);
}
