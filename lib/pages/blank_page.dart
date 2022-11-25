import 'package:flutter/material.dart';

import 'base_page.dart';

class BlankPage extends BasePage {
  const BlankPage({
    super.key = const ValueKey(pageName),
    super.name = pageName,
  });

  static const String pageName = 'blank';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const BlankScreen();
      },
    );
  }
}

class BlankScreen extends StatefulWidget {
  const BlankScreen({super.key});

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
