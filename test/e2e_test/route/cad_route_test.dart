import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import '../../../integration_test/cad_route_test.dart';

void main() {
  testWidgets('$CadRoute E2E Test', (WidgetTester tester) async {
    await pumpCadRouteAsNormalLink(tester);
  });
}
