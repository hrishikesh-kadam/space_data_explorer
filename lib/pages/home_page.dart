import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../globals.dart';
import '../nasa/nasa_page.dart';
import 'base_page.dart';

class HomePage extends BasePage {
  const HomePage({
    super.child = const HomeScreen(),
    super.key = const ValueKey(path),
    super.name = path,
    super.previousPage,
  });

  static const String path = '/';
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
        child: const Text(NasaPage.pageName),
        onPressed: () async {
          GoRouter.of(context).go(NasaPage.path, extra: getExtra());
        },
      ),
    );
  }
}
