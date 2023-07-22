import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../test/src/helper/helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Golden Screenshots Integration Test',
      (WidgetTester tester) async {
    const imageNameSuffix = String.fromEnvironment('IMAGE_NAME_SUFFIX');
    app.main(
      debugShowCheckedModeBanner: false,
    );
    await testScreenshot('1$imageNameSuffix.png', tester, binding);

    await tester.tap(find.byKey(HomeScreen.nasaButtonKey));
    await testScreenshot('2$imageNameSuffix.png', tester, binding);

    await tester.tap(find.byKey(NasaScreen.cadButtonKey));
    await testScreenshot('3$imageNameSuffix.png', tester, binding);
  });
}
