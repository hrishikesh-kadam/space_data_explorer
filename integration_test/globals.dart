import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/constants.dart';
import 'test_helper.dart';

final testLog = Logger('$appNamePascalCase.Test');
final printLog = Logger('${testLog.fullName}.Print')..level = Level.ALL;

String testType = _testType ??= getTestType();
String? _testType;
