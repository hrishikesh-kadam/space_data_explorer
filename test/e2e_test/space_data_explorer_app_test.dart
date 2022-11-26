import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/pages/home_page.dart';

import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  testWidgets('SpaceDataExplorerApp E2E Test', (WidgetTester tester) async {
    await landingPageIntegrationTest(tester);
  });
}

Future<void> landingPageIntegrationTest(WidgetTester tester) async {
  await tester.pumpWidget(SpaceDataExplorerApp());
  expect(find.byType(HomeScreen), findsOneWidget);
}
