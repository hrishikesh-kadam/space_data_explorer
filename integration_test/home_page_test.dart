import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'space_data_explorer_app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage Integration Test', (WidgetTester tester) async {
    await homePageIntegrationTest(tester);
  });
}

Future<void> homePageIntegrationTest(WidgetTester tester) async {
  await landingPageIntegrationTest(tester);
}
