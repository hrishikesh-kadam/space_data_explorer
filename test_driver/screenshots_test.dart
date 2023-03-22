import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

import 'package:space_data_explorer/globals.dart';

// TODO(hrishikesh-kadam): onScreenshot() not working
Future<void> main() async {
  log.fine('-> test_driver/screenshots_test.dart');
  try {
    await integrationDriver(
      onScreenshot: (String name, List<int> bytes,
          [Map<String, Object?>? args]) async {
        log.fine('-> onScreenshot');
        final imageFile =
            await File('screenshots/$name').create(recursive: true);
        imageFile.writeAsBytesSync(bytes);
        return true;
      },
    );
  } catch (e) {
    log.severe('-> test_driver/screenshots_test.dart -> Error occured: $e');
  }
}
