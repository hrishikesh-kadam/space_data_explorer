import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/constants/constants.dart';

final testLog = Logger('$appNamePascalCase.Test');
final printLog = Logger('${testLog.fullName}.Print')..level = Level.ALL;

String testType = _testType ??= getTestType();
String? _testType;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'appKey');

final AppLocalizations l10n = AppLocalizationsEn();
const MaterialLocalizations ml10n = DefaultMaterialLocalizations();
