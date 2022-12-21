import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/space_data_explorer_app_test.dart';

void main() {
  testWidgets('SpaceDataExplorerApp E2E Test', (WidgetTester tester) async {
    await landingPageIntegrationTest(tester);
  });
}
