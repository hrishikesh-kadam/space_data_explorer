import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/globals.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source/nasa_source_screen.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_page.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

void main() {
  testWidgets('NasaSourcePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(SpaceDataExplorerApp(
      initialLocation: NeowsPage.path,
    ));
    final int count = await tester.pumpAndSettle();
    configureLogging();
    log.fine('${NeowsPage.path} pumped for $count');
    expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    expect(find.byType(NasaSourceScreen, skipOffstage: false), findsOneWidget);
    expect(find.byType(NeowsScreen), findsOneWidget);
  });
}
