import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/space_data_explorer_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SpaceDataExplorerApp Integration Test',
      (WidgetTester tester) async {
    await pumpApp(tester);
  });
}
