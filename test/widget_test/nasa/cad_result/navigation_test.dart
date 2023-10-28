import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';

import 'package:space_data_explorer/globals.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import '../../../src/globals.dart';
import '../../../src/nasa/cad/cad_route.dart';
import '../../../src/nasa/cad_result/cad_result_route.dart';
import '../../../src/space_data_explorer_app.dart';

void main() {
  group('$CadResultRoute Widget Test', () {
    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpCadResultRouteAsNormalLink(tester);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
    });

    testWidgets('As initialLocation', (WidgetTester tester) async {
      await pumpCadResultRouteAsInitialLocation(tester);
      expect(find.byType(CadScreen), findsOneWidget);
    });

    testWidgets('extra[SbdbCadBody] JsonMap', (WidgetTester tester) async {
      await pumpCadRouteAsNormalLink(tester);
      JsonMap routeExtraMap = getRouteExtraMap();
      routeExtraMap['$SbdbCadBody'] = SbdbCadBodyExt.getSampleJsonMap('200/0');
      CadResultRoute($extra: routeExtraMap).go(navigatorKey.currentContext!);
      await tester.pumpAndSettle();
      expect(find.byType(CadResultScreen), findsOneWidget);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
    });

    testWidgets('Deep-link', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          CadResultRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(CadScreen), findsOneWidget);
    });
  });
}
