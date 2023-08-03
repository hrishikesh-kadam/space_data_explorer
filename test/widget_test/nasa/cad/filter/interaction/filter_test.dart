import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/filter/date.dart';

void main() {
  group('$CadRoute Filter Interaction Test', () {
    testWidgets('$DateFilter', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      await tester.tap(find.byKey(CadScreen.searchButtonKey));
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
    });
  });
}
