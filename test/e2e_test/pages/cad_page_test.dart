import 'package:flutter_test/flutter_test.dart';

import '../../../integration_test/cad_page_test.dart';

void main() {
  testWidgets('CadPage E2E Test', (WidgetTester tester) async {
    await pumpCadPageAsNormalLink(tester);
  });
}
