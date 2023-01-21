import 'package:flutter/scheduler.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/main.dart' as app;
import 'package:space_data_explorer/pages/home_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SpaceDataExplorerApp Integration Test',
      (WidgetTester tester) async {
    await landingPageIntegrationTest(tester);
  });
}

/*
 * TODO(hrishikesh-kadam): Check if the following issue is resolved.
 * https://github.com/flutter/flutter/issues/102469 
 */
Future<void> landingPageIntegrationTest(WidgetTester tester) async {
  timeDilation = 1.0;
  app.main();
  await tester.pumpAndSettle();
  expect(find.byType(HomeScreen), findsOneWidget);
}
