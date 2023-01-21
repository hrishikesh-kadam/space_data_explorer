import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/globals.dart';

import 'test_utility_non_web.dart'
    if (dart.library.html) 'test_utility_web.dart' as platform;

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  platform.checkHistoryLengthAndSerialCount(historyLength, serialCount);
}

Future<void> takeScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  log.fine('-> takeScreenshot');
  await platform.takeScreenshot(name, tester, binding);
}
