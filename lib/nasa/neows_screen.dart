import 'package:flutter/material.dart';

import '../../config/config.dart';
import 'neows_page.dart';

class NeowsScreen extends StatefulWidget {
  const NeowsScreen({super.key});

  @override
  State<NeowsScreen> createState() => _NeowsScreenState();
}

class _NeowsScreenState extends State<NeowsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
        context: context,
        title: const Text(NeowsPage.displayName),
      ),
    );
  }
}