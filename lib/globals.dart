import 'package:logging/logging.dart';

final log = Logger('space-data-explorer');

const isNormalLink = 'isNormalLink';

/// isNormalLink is used to check if the page was opened by normal-link or deep-link.
Map getExtra() {
  final Map extra = {};
  extra[isNormalLink] = true;
  return extra;
}
