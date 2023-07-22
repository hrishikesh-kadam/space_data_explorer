import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

import '../src/space_data_explorer_app.dart';

void main() {
  testWidgets('$SpaceDataExplorerApp Widget Test', (WidgetTester tester) async {
    await pumpApp(tester);
  });
}
