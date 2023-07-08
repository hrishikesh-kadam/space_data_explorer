import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/route/home_route.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('$HomeRoute Integration Test', (WidgetTester tester) async {
    await pumpHomeRouteIntegrationTest(tester);
  });
}

Future<void> pumpHomeRoute(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp());
  expect(find.byType(HomeScreen), findsOneWidget);
}

Future<void> pumpHomeRouteIntegrationTest(WidgetTester tester) async {
  configureApp();
  pumpHomeRoute(tester);
}
