import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/pages/home_page.dart';

import '../../../integration_test/home_page_test.dart';

void main() {
  testWidgets('$HomePage E2E Test', (WidgetTester tester) async {
    await pumpHomePageIntegrationTest(tester);
  });
}
