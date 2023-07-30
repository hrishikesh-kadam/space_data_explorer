import 'package:flutter/widgets.dart';

import '../constants/dimensions.dart';
import '../constants/theme.dart';

class QueryFilterContainer extends StatelessWidget {
  const QueryFilterContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.cadQueryFilterWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppTheme.filterContainerBorderColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(
          Dimensions.cadQueryFilterRadius,
        )),
        color: AppTheme.filterContainerColor,
      ),
      padding: const EdgeInsets.all(Dimensions.cadQueryFilterPadding),
      margin: const EdgeInsets.all(Dimensions.cadQueryFilterMargin),
      child: child,
    );
  }
}
