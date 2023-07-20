import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../../integration_test/home_route_helper.dart';

void main() {
  group('$HomeRoute Widget Test', () {
    testWidgets('Basic', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
    });

    testWidgets('Navigate to and from $NasaRoute', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
      await tester.tap(find.byKey(HomeScreen.nasaButtonKey));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
