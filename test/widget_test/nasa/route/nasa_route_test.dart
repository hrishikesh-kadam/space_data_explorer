import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../src/nasa/route/nasa_route.dart';
import '../../../src/space_data_explorer_app.dart';

void main() {
  group('$NasaRoute Widget Test', () {
    testWidgets('Navigate to and from $CadRoute', (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
      await tapCadButton(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('As initialLocation', (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Deep-link', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
