import 'package:flutter_test/flutter_test.dart';

import '../../../integration_test/home_page_test.dart';

void main() {
  testWidgets('HomePage E2E Test', (WidgetTester tester) async {
    await homePageIntegrationTest(tester);
  });
}
