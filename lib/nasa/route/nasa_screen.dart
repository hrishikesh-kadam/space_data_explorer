import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../config/config.dart';
import '../../globals.dart';
import '../../route/home/home_route.dart';
import '../../route/page_not_found/page_not_found_route.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/directionality_widget.dart';
import '../cad/cad_route.dart';

class NasaScreen extends StatelessWidget {
  NasaScreen({
    super.key,
    required this.title,
    required this.l10n,
  });

  final String title;
  final AppLocalizations l10n;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.NasaScreen');
  static const String keyPrefix = 'nasa_screen_';
  static const Key cadButtonKey = Key('${keyPrefix}cad_button_key');
  static const Key nonExistingPathButtonKey =
      Key('${keyPrefix}non_existing_path_button_key');

  @override
  Widget build(BuildContext context) {
    return getDirectionality(
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(title),
        ),
        body: Column(
          children: [
            TextButton(
              key: cadButtonKey,
              child: const Text(CadRoute.routeName),
              onPressed: () async {
                CadRoute($extra: getRouteExtraMap()).go(context);
              },
            ),
            if (!prodRelease)
              TextButton(
                key: nonExistingPathButtonKey,
                child: const Text(PageNotFoundRoute.nonExistingPath),
                onPressed: () async {
                  context.go(
                    PageNotFoundRoute.nonExistingPath,
                    extra: getRouteExtraMap(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
