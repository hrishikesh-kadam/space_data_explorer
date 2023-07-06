import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/config.dart';
import '../../constants/localisation.dart';
import '../../globals.dart';
import 'cad_page.dart';
import 'result/cad_result_page.dart';

class CadScreen extends StatefulWidget {
  const CadScreen({super.key});

  @override
  State<CadScreen> createState() => _CadScreenState();
}

class _CadScreenState extends State<CadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
        context: context,
        title: const Text(CadPage.displayName),
      ),
      body: TextButton(
        child: const Text(AppLocalisations.search),
        onPressed: () async {
          GoRouter.of(context).go(CadResultPage.path, extra: getExtra());
        },
      ),
    );
  }
}
