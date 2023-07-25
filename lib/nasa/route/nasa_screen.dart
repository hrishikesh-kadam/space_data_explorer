import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';

import '../../constants/constants.dart';
import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../cad/cad_route.dart';
import 'nasa_route.dart';

class NasaScreen extends StatelessWidget {
  NasaScreen({super.key});

  static const Key cadButtonKey = Key('nasa_screen_cad_button');
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.NasaScreen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(NasaRoute.displayName),
      ),
      body: TextButton(
        key: cadButtonKey,
        child: const Text(CadRoute.relativePath),
        onPressed: () async {
          CadRoute($extra: getRouteExtra()).go(context);
        },
      ),
    );
  }
}
