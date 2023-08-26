import 'dart:io';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

import '../test/src/globals.dart';

// TODO(hrishikesh-kadam): onScreenshot() not working
Future<void> main() async {
  testLogger.finest('test_driver/screenshots_test.dart');
  try {
    await integrationDriver(
      onScreenshot: (String name, List<int> bytes,
          [Map<String, Object?>? args]) async {
        testLogger.finest('onScreenshot');
        final imageFile =
            await File('screenshots/$name').create(recursive: true);
        imageFile.writeAsBytesSync(bytes);
        return true;
      },
    );
  } catch (e) {
    testLogger.error('test_driver/screenshots_test.dart -> Error occured: $e');
  }
}
