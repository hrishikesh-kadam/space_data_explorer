import 'package:flutter_test/flutter_test.dart';

import '../../../integration_test/neows_page_test.dart';

void main() {
  testWidgets('NeowsPage E2E Test', (WidgetTester tester) async {
    await neowsPageIntegrationTest(tester);
  });
}
