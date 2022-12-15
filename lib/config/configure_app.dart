import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'configure_non_web.dart' if (dart.library.html) 'configure_web.dart'
    as platform;

void configureApp() {
  setUrlStrategy(const HashUrlStrategy());
  configureLogging();
}

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
}) {
  return platform.getPlatformSpecificAppBar(
    context: context,
    title: title,
  );
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
      late final String emojiSpacer;
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
      emojiSpacer = emoji.isNotEmpty ? ' ' : '';
      print(
        '${record.loggerName}: '
        '$color'
        '$emoji'
        '$emojiSpacer'
        '${record.level.name}: ${record.time}: ${record.message}'
        '$resetColor',
      );
    }
  });
}
