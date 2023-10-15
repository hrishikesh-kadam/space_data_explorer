import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import '../test/src/helper/helper.dart';
import '../test/src/nasa/route/nasa_route.dart';
import '../test/src/route/home/home_route.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Golden Screenshots Integration Test',
      (WidgetTester tester) async {
    const imageNameSuffix = String.fromEnvironment('IMAGE_NAME_SUFFIX');
    app.main(
      debugShowCheckedModeBanner: false,
    );
    await testScreenshot('1$imageNameSuffix.png', tester, binding);

    await tapNasaItem(tester);
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    await tapCadButton(tester);
    await testScreenshot('3$imageNameSuffix.png', tester, binding);
  });
}
