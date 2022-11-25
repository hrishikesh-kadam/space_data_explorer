import 'package:flutter/material.dart';

import 'base_page.dart';
import 'nasa_source_page.dart';

class NeowsPage extends BasePage {
  const NeowsPage({
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'neows';
  static const String path = '${NasaSourcePage.path}/$pageName';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const NeowsScreen();
      },
    );
  }
}

class NeowsScreen extends StatefulWidget {
  const NeowsScreen({super.key});

  @override
  State<NeowsScreen> createState() => _NeowsScreenState();
}

class _NeowsScreenState extends State<NeowsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeoWs Screen'),
      ),
    );
  }
}
