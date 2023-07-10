import 'package:flutter/material.dart';

import '../config/config.dart';
import '../constants/dimensions.dart';
import '../constants/localisation.dart';
import '../constants/theme.dart';

class DeferredPlaceholderWidget extends StatelessWidget {
  const DeferredPlaceholderWidget({
    super.key,
    this.name = AppLocalisations.deferredTitle,
  });

  final String name;
  static const double indicatorHeight =
      Dimensions.linearProgressIndicatorHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPlatformSpecificAppBar(
          context: context,
          title: Text(name),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(indicatorHeight),
            child: LinearProgressIndicator(
              value: null,
              color: AppTheme.progressIndicatorColor,
              minHeight: indicatorHeight,
            ),
          )),
    );
  }
}
