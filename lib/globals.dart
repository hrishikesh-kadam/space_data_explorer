import 'package:flutter/foundation.dart';

import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:recase/recase.dart';

import 'constants/constants.dart';
import 'coverage_ignored.dart';

final String appNamePascalCase = Constants.appName.pascalCase;

final bool flutterTest = isFlutterTest();
final bool flutterIntegrationTest = isFlutterIntegrationTest();

final logger = Logger(appNamePascalCase);

/// isNormalLink is used to check if the route was opened by normal-link or
/// deep-link.
const isNormalLink = 'isNormalLink';

JsonMap getRouteExtraMap() {
  JsonMap extra = {};
  extra[isNormalLink] = true;
  return extra;
}

final bool keyboardVisibilitySupported = isKeyboardVisibilitySupported();

@visibleForTesting
bool isSurfaceRendered = false;
