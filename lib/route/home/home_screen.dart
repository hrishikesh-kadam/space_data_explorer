import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

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
  static const Key nasaButtonKey = Key('home_screen_nasa_button');

  @override
  Widget build(BuildContext context) {
    return getDirectionality(
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(title),
        ),
        body: TextButton(
          key: nasaButtonKey,
          child: const Text(NasaRoute.routeName),
          onPressed: () async {
            GoRouter.of(context).go(NasaRoute.path, extra: getRouteExtraMap());
          },
        ),
      ),
    );
  }
}
