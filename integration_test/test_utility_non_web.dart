import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

import 'package:space_data_explorer/globals.dart' hide log;
import 'globals.dart';

void resetNavigationHistoryState() {
  throw UnimplementedError('Not evaluated for non Web Platforms yet');
}

void logNavigationHistoryState() {
  throw UnimplementedError('Not evaluated for non Web Platforms yet');
}

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
    log.info('-> testScreenshot -> UPDATE_GOLDENS=$updateGoldens');
  }
  await tester.pumpAndSettle();
  final List<int> bytes = await binding.takeScreenshot(name);
  Directory directory = await getApplicationDocumentsDirectory();
  directory = Directory('${directory.path}/screenshots');
  await directory.create(recursive: true);
  final goldenFile = File('${directory.path}/$name');
  if (Platform.isAndroid) {
    if (const bool.fromEnvironment('UPDATE_GOLDENS')) {
      log.info('-> testScreenshot -> ${goldenFile.path}');
      goldenFile.writeAsBytesSync(bytes);
    } else {
      // TODO(hrishikesh-kadam): Check if following code can be updated.
      // https://www.youtube.com/watch?v=7nrhTdS7dHg&list=PLjxrf2q8roU3LvrdR8Hv_phLrTj0xmjnD&index=6
      // At 12:00
      if (!const bool.hasEnvironment('GOLDEN_DIRECTORY')) {
        throw Exception('Dart Environment variable GOLDEN_DIRECTORY missing');
      }
      const goldenDirectory = String.fromEnvironment('GOLDEN_DIRECTORY');
      final goldenByteData = await rootBundle.load('$goldenDirectory/$name');
      final goldenByteBuffer = goldenByteData.buffer;
      final goldenBytes = goldenByteBuffer.asUint8List(
          goldenByteData.offsetInBytes, goldenByteBuffer.lengthInBytes);
      goldenFile.writeAsBytesSync(goldenBytes);
      await expectLater(bytes, matchesGoldenFile(goldenFile.uri));
    }
  } else {
    log.info('-> testScreenshot -> ${goldenFile.path}');
    await expectLater(bytes, matchesGoldenFile(goldenFile.uri));
  }
}
