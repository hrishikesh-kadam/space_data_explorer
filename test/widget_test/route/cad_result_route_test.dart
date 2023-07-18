import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad/result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad/result/cad_result_screen.dart';
import '../../../integration_test/cad_result_route_test.dart';

void main() {
  group('$CadResultRoute Widget Test', () {
    testWidgets('Navigate back from $CadResultRoute',
        (WidgetTester tester) async {
      await pumpCadResultRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
    }, skip: true);

    testWidgets('$CadResultRoute', (WidgetTester tester) async {
      await pumpCadResultRouteAsInitialLocation(tester);
    });
  });
}
