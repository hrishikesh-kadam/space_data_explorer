import 'package:flutter_test/flutter_test.dart';

import '../../../integration_test/nasa_source_page_test.dart';

void main() {
  testWidgets('NasaSourcePage E2E Test', (WidgetTester tester) async {
    await nasaSourcePageIntegrationTest(tester);
  });
}
