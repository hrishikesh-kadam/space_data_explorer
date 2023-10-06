// coverage:ignore-file

import 'package:flutter/foundation.dart';

import 'package:recase/recase.dart';

import 'constants/constants.dart';

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
