import 'package:flutter/material.dart';

import '../config/configure_app.dart';

class DeferredLoadingPlaceholder extends StatelessWidget {
  const DeferredLoadingPlaceholder({
    super.key,
    this.name = defaultName,
  });

  final String name;
  // TODO(hrishikesh-kadam): LABEL:string-constant
  static const String defaultName = 'Loading... Please Wait!';
  static const double indicatorHeight = 6;

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
              // TODO(hrishikesh-kadam): LABEL:theme-constant
              color: Colors.blue[900],
              minHeight: indicatorHeight,
            ),
          )),
    );
  }
}
