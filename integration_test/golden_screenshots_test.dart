import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/nasa/nasa_page.dart';
import 'package:space_data_explorer/nasa/neows_page.dart';
import 'test_helper.dart';

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
        find.widgetWithText(TextButton, NasaPage.pageName);
    await tester.tap(nasaSourceTextButton);
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    final neowsTextButton = find.widgetWithText(TextButton, NeowsPage.pageName);
    await tester.tap(neowsTextButton);
    await testScreenshot('3$imageNameSuffix.png', tester, binding);
  });
}
