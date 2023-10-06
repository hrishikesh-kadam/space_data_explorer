// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../../config/config.dart';
import '../../../globals.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/directionality_widget.dart';

class LicenseScreen extends StatelessWidget {
  LicenseScreen({
    super.key,
    required this.title,
    required this.l10n,
  });

  final String title;
  final AppLocalizations l10n;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.LicenseScreen');
  static const String keyPrefix = 'license_screen_';

  @override
  Widget build(BuildContext context) {
    return getDirectionality(
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(title),
        ),
        body: LicensePage(
          applicationName: l10n.spaceDataExplorer,
          applicationVersion: getCompleteVersion(),
        ),
      ),
    );
  }
}
