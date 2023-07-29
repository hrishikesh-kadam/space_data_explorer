import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helper_non_web.dart' if (dart.library.html) 'helper_web.dart'
    as platform;

void resetNavigationHistoryState() {
  platform.resetNavigationHistoryState();
}

void logNavigationHistoryState() {
  platform.logNavigationHistoryState();
}

bool verifyHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  return platform.verifyHistoryLengthAndSerialCount(historyLength, serialCount);
}

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await platform.testScreenshot(name, tester, binding);
}
