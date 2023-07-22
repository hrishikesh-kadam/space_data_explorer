import 'package:flutter/material.dart';

import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../widgets/app_bar.dart';
import 'cad_result_route.dart';

class CadResultScreen extends StatelessWidget {
  const CadResultScreen({
    super.key,
    required this.sbdbCadBody,
  });

  final SbdbCadBody sbdbCadBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(CadResultRoute.displayName),
      ),
      body: Text(sbdbCadBody.count.toString()),
    );
  }
}
