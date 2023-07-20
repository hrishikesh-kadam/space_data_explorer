import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/space_data_explorer.dart';
import '../../integration_test/space_data_explorer_app_test.dart';

void main() {
  testWidgets('$SpaceDataExplorerApp Widget Test', (WidgetTester tester) async {
    await pumpApp(tester);
  });
}
