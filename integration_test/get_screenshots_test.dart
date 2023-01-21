import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/pages/nasa_source_page.dart';
import 'package:space_data_explorer/pages/neows_page.dart';
import 'test_utility.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Screenshots Integration Test', (WidgetTester tester) async {
    app.main(
      debugShowCheckedModeBanner: false,
    );
    await takeScreenshot('1.png', tester, binding);

    final nasaSourceTextButton =
        find.widgetWithText(TextButton, NasaSourcePage.pageName);
    await tester.tap(nasaSourceTextButton);
    await takeScreenshot('2.png', tester, binding);

    final neowsTextButton = find.widgetWithText(TextButton, NeowsPage.pageName);
    await tester.tap(neowsTextButton);
    await takeScreenshot('3.png', tester, binding);
  });
}
