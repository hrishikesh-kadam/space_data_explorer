import 'package:logging/logging.dart';

import 'package:space_data_explorer/constants.dart';
import 'test_utility.dart';

final log = Logger('$appNameKebabCase-test');

String testType = _testType ??= getTestType();
String? _testType;
