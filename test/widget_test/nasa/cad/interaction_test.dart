import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/nasa/cad/cad_route.dart';
import '../../../src/nasa/cad/query/date_filter.dart';

void main() {
  group('$CadRoute Query Interaction Test', () {
    testWidgets('$DateRange', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      await tapSearchButton(tester);
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
    });

    testWidgets('Tap all links', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSourceLink(tester);
    });
  });
}
