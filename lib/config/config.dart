import 'package:flutter/material.dart';

import 'logging.dart';

// ignore: directives_ordering
import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

void configureApp() {
  configureUrlStrategy();
  configureLogging();
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
