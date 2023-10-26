import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    try {
      Future<ByteData> font =
          rootBundle.load('assets/fonts/Roboto/Roboto-Regular.ttf');
      FontLoader fontLoader = FontLoader('Roboto')..addFont(font);
      await fontLoader.load();
      font = rootBundle
          .load('assets/fonts/MaterialIcons/MaterialIcons-Regular.otf');
      fontLoader = FontLoader('MaterialIcons')..addFont(font);
      await fontLoader.load();
      // ignore: empty_catches
    } catch (e) {}
  });

  await testMain();
}
