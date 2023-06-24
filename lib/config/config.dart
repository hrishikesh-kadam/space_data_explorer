import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';

// ignore: directives_ordering
import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

void configureApp() {
  configureUrlStrategy();
  configureHrkLogging();
}

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
  PreferredSizeWidget? bottom,
}) {
  return platform.getPlatformSpecificAppBar(
    context: context,
    title: title,
    bottom: bottom,
  );
}

void configureUrlStrategy() {
  platform.configureUrlStrategy();
}
