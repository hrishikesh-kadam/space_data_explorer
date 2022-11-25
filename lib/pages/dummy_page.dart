import 'package:flutter/material.dart';

import 'base_page.dart';

class DummyPage extends BasePage {
  const DummyPage({
    super.child = const DummyScreen(),
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  const DummyPage.one({
    previousPage,
  }) : this(
          child: const DummyScreen(title: '${DummyPage.defaultTitle} 1'),
          key: const ValueKey(DummyPage.pageName1),
          name: DummyPage.pageName1,
          previousPage: previousPage,
        );

  const DummyPage.two({
    previousPage,
  }) : this(
          child: const DummyScreen(title: '${DummyPage.defaultTitle} 2'),
          key: const ValueKey(DummyPage.pageName2),
          name: DummyPage.pageName2,
          previousPage: previousPage,
        );

  static const String pageName = 'dummy-page';
  static const String pageName1 = 'dummy-page-1';
  static const String pageName2 = 'dummy-page-2';
  static const String defaultTitle = 'Dummy Page';
}

class DummyScreen extends StatefulWidget {
  const DummyScreen({
    super.key,
    this.title = DummyPage.defaultTitle,
  });

  final String title;

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
