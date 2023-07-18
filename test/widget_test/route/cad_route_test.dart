import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import '../../../integration_test/cad_route_test.dart';

void main() {
  group('$CadRoute Widget Test', () {
    testWidgets('Navigate back from $CadRoute', (WidgetTester tester) async {
      await pumpCadRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('$CadRoute', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
    });
  });
}
