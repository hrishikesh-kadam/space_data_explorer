import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  testWidgets('SpaceDataExplorerApp Widget Test', (WidgetTester tester) async {
    configureApp();
    await tester.pumpWidget(SpaceDataExplorerApp());
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
