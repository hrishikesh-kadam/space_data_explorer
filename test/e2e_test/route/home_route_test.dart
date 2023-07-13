import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_route.dart';
import '../../../integration_test/home_route_test.dart';

void main() {
  testWidgets('$HomeRoute E2E Test', (WidgetTester tester) async {
    await pumpHomeRouteIntegrationTest(tester);
  });
}
