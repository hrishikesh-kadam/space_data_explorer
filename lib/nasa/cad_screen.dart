import 'package:flutter/material.dart';

import '../../config/config.dart';
import 'cad_page.dart';

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
    );
  }
}
