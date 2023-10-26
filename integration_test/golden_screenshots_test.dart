import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import '../test/src/helper/helper.dart';
import '../test/src/nasa/route/nasa_route.dart';
import '../test/src/route/about/about_route.dart';
import '../test/src/route/home/home_route.dart';
import '../test/src/route/settings/settings_route.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Golden Screenshots Integration Test',
      (WidgetTester tester) async {
    const imageNameSuffix = String.fromEnvironment('IMAGE_NAME_SUFFIX');
    await app.main(
      debugShowCheckedModeBanner: false,
    );
    await tester.pumpAndSettle();
    await testScreenshot('1$imageNameSuffix.png', tester, binding);

    await tapNasaItem(tester);
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    await tapCadButton(tester);
    await testScreenshot('3$imageNameSuffix.png', tester, binding);

    await tapBackButton(tester);
    await tapBackButton(tester);
    await tapSettingsAction(tester);
    await testScreenshot('4$imageNameSuffix.png', tester, binding);
    await tapBackButton(tester);

    await tapAboutAction(tester);
    await testScreenshot('5$imageNameSuffix.png', tester, binding);
  });
}
