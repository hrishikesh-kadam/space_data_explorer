import 'package:flutter_test/flutter_test.dart';

import '../space_data_explorer_app_test.dart';

void main() {
  testWidgets('HomePage E2E Test', (WidgetTester tester) async {
    await landingPageIntegrationTest(tester);
  });
}
