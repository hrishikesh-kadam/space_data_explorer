import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';

// ignore: directives_ordering
import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

void configureApp() {
  configureUrlStrategy();
  configureHrkLogging();
}

BackButton getAppBarBackButton({
  required BuildContext context,
}) {
  return platform.getAppBarBackButton(context: context);
}

void configureUrlStrategy() {
  platform.configureUrlStrategy();
}
