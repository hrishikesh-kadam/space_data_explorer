import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'space_data_explorer_app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('$HomeRoute Integration Test', (WidgetTester tester) async {
    await pumpHomeRoute(tester);
  });
}

Future<void> pumpHomeRoute(WidgetTester tester) async {
  await pumpApp(tester);
  expect(find.byType(HomeScreen), findsOneWidget);
}
