import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'base_page.dart';
import 'nasa_source_page.dart';

class HomePage extends BasePage {
  const HomePage({
    super.key = const ValueKey(path),
    super.name = path,
    super.previousPage,
  });

  static const String path = '/';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const HomeScreen();
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: TextButton(
        child: const Text(NasaSourcePage.pageName),
        onPressed: () async {
          GoRouter.of(context).go(NasaSourcePage.path);
        },
      ),
    );
  }
}
