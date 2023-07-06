import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/nasa/cad_page.dart';
import 'package:space_data_explorer/nasa/nasa_page.dart';
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

    final nasaTextButton =
        find.widgetWithText(TextButton, NasaPage.pageName);
    await tester.tap(nasaTextButton);
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    final cadTextButton = find.widgetWithText(TextButton, CadPage.pageName);
    await tester.tap(cadTextButton);
    await testScreenshot('3$imageNameSuffix.png', tester, binding);
  });
}
