import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import 'settings_route.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(SettingsRoute.displayName),
      ),
    );
  }
}
