// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:recase/recase.dart';

import 'constants/constants.dart';
import 'globals.dart';

final String appNameKebabCase = Constants.appName.paramCase;

// https://github.com/MisterJimson/flutter_keyboard_visibility
bool isKeyboardVisibilitySupported() {
  if (kIsWeb) {
    return false;
  } else {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false
    };
  }
}

// LABEL: eligible-hrk_flutter_batteries
void printMediaQuery(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  logger.debug('mediaQuery.size = ${mediaQuery.size}');
  logger.debug('mediaQuery.devicePixelRatio = ${mediaQuery.devicePixelRatio}');
}
