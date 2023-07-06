import 'package:flutter/material.dart';

import '../../../config/config.dart';
import 'cad_result_page.dart';

class CadResultScreen extends StatefulWidget {
  const CadResultScreen({super.key});

  @override
  State<CadResultScreen> createState() => _CadResultScreenState();
}

class _CadResultScreenState extends State<CadResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
        context: context,
        title: const Text(CadResultPage.displayName),
      ),
    );
  }
}
