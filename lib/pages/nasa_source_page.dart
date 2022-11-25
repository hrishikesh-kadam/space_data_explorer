import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'base_page.dart';
import 'home_page.dart';
import 'neows_page.dart';

class NasaSourcePage extends BasePage {
  const NasaSourcePage({
    super.child = const NasaSourceScreen(),
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'nasa-source';
  static const String path = '${HomePage.path}$pageName';
}

class NasaSourceScreen extends StatefulWidget {
  const NasaSourceScreen({super.key});

  @override
  State<NasaSourceScreen> createState() => _NasaSourceScreenState();
}

class _NasaSourceScreenState extends State<NasaSourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA Source Screen'),
      ),
      body: TextButton(
        child: const Text(NeowsPage.pageName),
        onPressed: () async {
          GoRouter.of(context).go(NeowsPage.path);
        },
      ),
    );
  }
}
