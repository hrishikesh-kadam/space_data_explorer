import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../integration_test/nasa_route_helper.dart';

void main() {
  group('$NasaRoute Widget Test', () {
    testWidgets('Navigate to and from $CadRoute', (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      await tester.tap(find.byKey(NasaScreen.cadButtonKey));
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('Basic', (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
    });

    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
