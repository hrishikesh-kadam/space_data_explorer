import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage Integration Test', (WidgetTester tester) async {
    await pumpHomePageIntegrationTest(tester);
  });
}

Future<void> pumpHomePage(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp());
  expect(find.byType(HomeScreen), findsOneWidget);
}

Future<void> pumpHomePageIntegrationTest(WidgetTester tester) async {
  configureApp();
  pumpHomePage(tester);
}
