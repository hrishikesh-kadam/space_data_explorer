import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/nasa/nasa_page.dart';

import '../../../integration_test/nasa_source_page_test.dart';

void main() {
  testWidgets('$NasaPage E2E Test', (WidgetTester tester) async {
    await pumpNasaSourcePageAsNormalLink(tester);
  });
}
