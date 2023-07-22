import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../src/nasa/cad_result/cad_result_route.dart';

void main() {
  group('$CadResultRoute Widget Test', () {
    testWidgets('Navigate back', (WidgetTester tester) async {
      await pumpCadResultRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(CadResultScreen), findsNothing);
      expect(find.byType(CadScreen), findsOneWidget);
    });

    testWidgets('Basic', (WidgetTester tester) async {
      await pumpCadResultRouteAsInitialLocation(tester);
    });
  });
}
