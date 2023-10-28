import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import '../../../src/nasa/cad/cad_route.dart';
import '../../../src/space_data_explorer_app.dart';

void main() {
  group('$CadRoute Widget Navigation Test', () {
    testWidgets('Navigate to and from $CadResultRoute',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapSearchButton(tester);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
    });

    testWidgets('As initialLocation', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(find.byType(CadScreen), findsOneWidget);
    });

    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpCadRouteAsNormalLink(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('Deep-link', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
