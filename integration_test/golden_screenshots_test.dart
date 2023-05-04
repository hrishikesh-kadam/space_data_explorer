import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/pages/nasa_source/nasa_source_page.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_page.dart';
import 'test_utility.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Golden Screenshots Integration Test',
      (WidgetTester tester) async {
    const imageNameSuffix = String.fromEnvironment('IMAGE_NAME_SUFFIX');
    app.main(
      debugShowCheckedModeBanner: false,
    );
    await testScreenshot('1$imageNameSuffix.png', tester, binding);

    final nasaSourceTextButton =
        find.widgetWithText(TextButton, NasaSourcePage.pageName);
    await tester.tap(nasaSourceTextButton);
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    final neowsTextButton = find.widgetWithText(TextButton, NeowsPage.pageName);
    await tester.tap(neowsTextButton);
    await testScreenshot('3$imageNameSuffix.png', tester, binding);
  });
}
