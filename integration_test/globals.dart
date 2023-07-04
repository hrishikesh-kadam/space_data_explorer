import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/constants.dart';

final testLog = Logger('$appNamePascalCase.Test');
final printLog = Logger('${testLog.fullName}.Print')..level = Level.ALL;

String testType = _testType ??= getTestType();
String? _testType;
