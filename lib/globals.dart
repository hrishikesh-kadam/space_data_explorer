import 'package:flutter/foundation.dart';

import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'constants/constants.dart';

bool flutterTest = isFlutterTest();

final log = Logger(appNamePascalCase);

/// isNormalLink is used to check if the route was opened by normal-link or
/// deep-link.
const isNormalLink = 'isNormalLink';

JsonMap getRouteExtraMap() {
  JsonMap extra = {};
  extra[isNormalLink] = true;
  return extra;
}

@visibleForTesting
bool isSurfaceRendered = false;
