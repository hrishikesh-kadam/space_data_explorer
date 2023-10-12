import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../../globals.dart';
import '../../nasa/route/nasa_route.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/directionality_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.l10n,
  });

  final String title;
  final AppLocalizations l10n;
  static const String keyPrefix = 'home_screen_';
  static const Key nasaButtonKey = Key('${keyPrefix}nasa_button_key');

  @override
  Widget build(BuildContext context) {
    return getDirectionality(
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(title),
        ),
        body: Link(
          uri: NasaRoute.uri,
          builder: (context, followLink) {
            return InkWell(
              key: nasaButtonKey,
              onTap: () {
                GoRouter.of(context)
                    .go(NasaRoute.uri.path, extra: getRouteExtraMap());
              },
              child: Text(
                NasaRoute.pathSegment,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
        ),
      ),
    );
  }
}
