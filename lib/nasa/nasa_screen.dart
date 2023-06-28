import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../config/config.dart';
import '../../globals.dart';
import 'nasa_page.dart';
import 'neows_page.dart';

class NasaScreen extends StatefulWidget {
  const NasaScreen({super.key});

  @override
  State<NasaScreen> createState() => _NasaScreenState();
}

class _NasaScreenState extends State<NasaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
        context: context,
        title: const Text(NasaPage.displayName),
      ),
      body: TextButton(
        child: const Text(NeowsPage.pageName),
        onPressed: () async {
          GoRouter.of(context).go(NeowsPage.path, extra: getExtra());
        },
      ),
    );
  }
}
