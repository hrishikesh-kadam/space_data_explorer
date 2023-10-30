import 'package:flutter/material.dart';

import '../config/config.dart';
import '../widgets/app_bar.dart';

class DeferredPlaceholderWidget extends StatelessWidget {
  const DeferredPlaceholderWidget({
    super.key,
    required this.title,
  });

  final String title;
  static const double indicatorHeight = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        leading: getAppBarBackButton(context: context),
        title: Text(title),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(indicatorHeight),
          child: LinearProgressIndicator(
            value: null,
            minHeight: indicatorHeight,
          ),
        ),
        deferedLoadingPlaceholder: true,
      ),
    );
  }
}
