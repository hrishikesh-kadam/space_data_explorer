import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

import 'package:space_data_explorer/globals.dart';

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  throw UnimplementedError('Not required for non Web Platforms');
}

Future<void> takeScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  if (Platform.isAndroid && !isSurfaceRendered) {
    await binding.convertFlutterSurfaceToImage();
    isSurfaceRendered = true;
  }
  await tester.pumpAndSettle();
  final List<int> bytes = await binding.takeScreenshot(name);
  Directory directory;
  if (Platform.isAndroid) {
    // https://github.com/flutter/plugins/blob/main/packages/path_provider/path_provider_android/android/src/main/java/io/flutter/plugins/pathprovider/PathProviderPlugin.java
    // https://developer.android.com/reference/android/content/Context#getExternalFilesDir(java.lang.String)
    directory = (await getExternalStorageDirectory())!;
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  final file = File('${directory.path}/$name');
  log.fine('-> takeScreenshot -> ${file.path}');
  file.writeAsBytesSync(bytes);
}
