import 'package:flutter/material.dart';

import '../config/config.dart';
import '../constants/dimensions.dart';
import '../constants/theme.dart';

class DeferredPlaceholderWidget extends StatelessWidget {
  const DeferredPlaceholderWidget({
    super.key,
    required this.name,
  });

  final String name;
  static const double indicatorHeight =
      Dimensions.linearProgressIndicatorHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getAppBarBackButton(context: context),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(indicatorHeight),
          child: LinearProgressIndicator(
            value: null,
            color: AppTheme.progressIndicatorColor,
            minHeight: indicatorHeight,
          ),
        ),
      ),
    );
  }
}
