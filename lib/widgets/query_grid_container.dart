import 'package:flutter/widgets.dart';

import '../constants/dimensions.dart';
import '../constants/theme.dart';

class QueryItemContainer extends StatelessWidget {
  const QueryItemContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.cadQueryItemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppTheme.queryContainerBorderColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(
          Dimensions.cadQueryItemRadius,
        )),
        color: AppTheme.queryContainerColor,
      ),
      padding: const EdgeInsets.all(Dimensions.cadQueryItemPadding),
      margin: const EdgeInsets.all(Dimensions.cadQueryItemMargin),
      child: child,
    );
  }
}
