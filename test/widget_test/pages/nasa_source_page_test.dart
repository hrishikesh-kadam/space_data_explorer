import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source_page.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  testWidgets('NasaSourcePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(SpaceDataExplorerApp(
      initialLocation: NasaSourcePage.path,
    ));
    expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    expect(find.byType(NasaSourceScreen), findsOneWidget);
  });
}
