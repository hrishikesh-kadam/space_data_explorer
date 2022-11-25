import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void configureApp() {
  setUrlStrategy(const HashUrlStrategy());
  configureLogging();
}

void configureLogging() {
  // Source - https://github.com/flutter/flutter/blob/master/packages/flutter_tools/lib/src/base/terminal.dart
  const String red = '\u001b[31m';
  const String green = '\u001b[32m';
  const String yellow = '\u001b[33m';
  const String blue = '\u001b[34m';
  const String resetColor = '\u001B[39m';

  // Mandatory steps - https://pub.dev/packages/logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      late final String color;
      late final String emoji;
      if (record.level == Level.SHOUT) {
        emoji = '😱';
        color = red;
      } else if (record.level == Level.SEVERE) {
        emoji = '🚫';
        color = red;
      } else if (record.level == Level.WARNING) {
        emoji = '🚧';
        color = yellow;
      } else if (record.level == Level.INFO) {
        emoji = '📗';
        color = green;
      } else if (record.level == Level.FINE) {
        emoji = '🐛';
        color = blue;
      } else {
        color = emoji = '';
      }
      print(
        '${record.loggerName}: '
        '$color'
        '$emoji ${record.level.name}: ${record.time}: ${record.message}'
        '$resetColor',
      );
    }
  });
}
