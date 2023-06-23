import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'constants.dart';
import 'helper/helper.dart';

bool flutterTest = isFlutterTest();

final log = Logger(appNamePascalCase);

const isNormalLink = 'isNormalLink';

/// isNormalLink is used to check if the page was opened by normal-link or deep-link.
Map getExtra() {
  final Map extra = {};
  extra[isNormalLink] = true;
  return extra;
}

@visibleForTesting
bool isSurfaceRendered = false;
