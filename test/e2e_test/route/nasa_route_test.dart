import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import '../../../integration_test/nasa_route_test.dart';

void main() {
  testWidgets('$NasaRoute E2E Test', (WidgetTester tester) async {
    await pumpNasaRouteAsNormalLink(tester);
  });
}
