import 'package:flutter/material.dart';

import 'base_page.dart';

class BlankPage extends BasePage {
  const BlankPage({
    super.child = const BlankScreen(),
    super.key = const ValueKey(pageName),
    super.name = pageName,
  });

  static const String pageName = 'blank';
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
