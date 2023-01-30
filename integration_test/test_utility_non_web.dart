import 'dart:io';

import 'package:flutter/services.dart';

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

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  if (Platform.isAndroid && !isSurfaceRendered) {
    await binding.convertFlutterSurfaceToImage();
    isSurfaceRendered = true;
    const updateGoldens = bool.fromEnvironment('UPDATE_GOLDENS');
    log.fine('-> testScreenshot -> UPDATE_GOLDENS=$updateGoldens');
  }
  await tester.pumpAndSettle();
  final List<int> bytes = await binding.takeScreenshot(name);
  Directory directory = await getApplicationDocumentsDirectory();
  directory = Directory('${directory.path}/screenshots');
  await directory.create(recursive: true);
  final goldenFile = File('${directory.path}/$name');
  if (Platform.isAndroid) {
    if (const bool.fromEnvironment('UPDATE_GOLDENS')) {
      log.fine('-> testScreenshot -> ${goldenFile.path}');
      goldenFile.writeAsBytesSync(bytes);
    } else {
      const goldenDirectory = String.fromEnvironment('GOLDEN_DIRECTORY');
      final goldenByteData = await rootBundle.load('$goldenDirectory/$name');
      final goldenByteBuffer = goldenByteData.buffer;
      final goldenBytes = goldenByteBuffer.asUint8List(
          goldenByteData.offsetInBytes, goldenByteBuffer.lengthInBytes);
      goldenFile.writeAsBytesSync(goldenBytes);
      await expectLater(bytes, matchesGoldenFile(goldenFile.uri));
    }
  } else {
    log.fine('-> testScreenshot -> ${goldenFile.path}');
    await expectLater(bytes, matchesGoldenFile(goldenFile.uri));
  }
}
