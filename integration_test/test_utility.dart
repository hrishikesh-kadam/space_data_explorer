import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_utility_non_web.dart'
    if (dart.library.html) 'test_utility_web.dart' as platform;

void resetNavigationHistoryState() {
  platform.resetNavigationHistoryState();
}

void logNavigationHistoryState() {
  platform.logNavigationHistoryState();
}

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  platform.checkHistoryLengthAndSerialCount(historyLength, serialCount);
}

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await platform.testScreenshot(name, tester, binding);
}
