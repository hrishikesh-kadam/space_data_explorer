import 'package:logging/logging.dart';

import 'package:space_data_explorer/constants.dart';
import 'test_utility.dart';

final testLog = Logger('$appNamePascalCase.Test');
final driveLog = Logger('${testLog.fullName}.Drive')..level = Level.ALL;

String testType = _testType ??= getTestType();
String? _testType;
