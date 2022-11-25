import 'package:flutter/material.dart';

import 'base_page.dart';

class NotFoundPage extends BasePage {
  NotFoundPage({
    invalidPath = pageName,
    super.previousPage,
  }) : super(
          child: const NotFoundScreen(),
          key: ValueKey(invalidPath),
          name: invalidPath,
        );

  static const String pageName = '404';
  static const String invalidPath = 'invalid-path';
}

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Found Page'),
      ),
    );
  }
}
