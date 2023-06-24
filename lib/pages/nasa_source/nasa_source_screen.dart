import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../config/config.dart';
import '../../globals.dart';
import 'nasa_source_page.dart';
import 'neows_page.dart';

class NasaSourceScreen extends StatefulWidget {
  const NasaSourceScreen({super.key});

  @override
  State<NasaSourceScreen> createState() => _NasaSourceScreenState();
}

class _NasaSourceScreenState extends State<NasaSourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
        context: context,
        title: const Text(NasaSourcePage.displayName),
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
