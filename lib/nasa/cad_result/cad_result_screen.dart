import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../widgets/app_bar.dart';
import '../../constants/dimensions.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import 'bloc/cad_result_bloc.dart';
import 'bloc/cad_result_state.dart';
import 'cad_result_route.dart';

class CadResultScreen extends StatelessWidget {
  CadResultScreen({
    super.key,
    required this.l10n,
    required this.routeExtraMap,
  });

  final AppLocalizations l10n;
  final JsonMap routeExtraMap;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.CadResultScreen');
  static const String keyPrefix = 'cad_result_screen_';
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key resultGridKey = Key('${keyPrefix}result_grid_key');
  @visibleForTesting
  static CadResultBloc? cadResultBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadResultBloc>(
      create: (_) {
        if (flutterTest && cadResultBloc != null) {
          return cadResultBloc!;
        } else {
          return CadResultBloc(
            sbdbCadBody: routeExtraMap['$SbdbCadBody'],
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.pageBackgroundColor,
        body: CustomScrollView(
          key: customScrollViewKey,
          controller: ScrollController(),
          slivers: [
            getSliverAppBar(
              context: context,
              title: const Text(CadResultRoute.displayName),
              floating: true,
              snap: true,
            ),
            ..._getBody(context: context)
          ],
        ),
      ),
    );
  }

  List<Widget> _getBody({required BuildContext context}) {
    return [
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
        ),
      ),
      _getResultGrid(context: context),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
        ),
      )
    ];
  }

  Widget _getResultGrid({required BuildContext context}) {
    final gridParameters = getSliverMasonryGridParameters(
      context: context,
      itemExtent: Dimensions.cadQueryItemExtent,
      pagePaddingHorizontal: Dimensions.pagePaddingHorizontal,
    );
    return BlocSelector<CadResultBloc, CadResultState, SbdbCadBody>(
      selector: (state) => state.sbdbCadBody,
      builder: (context, sbdbCadBody) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: gridParameters.$1,
          ),
          sliver: SliverMasonryGrid.count(
            key: resultGridKey,
            crossAxisCount: gridParameters.$2,
            childCount: sbdbCadBody.count,
            itemBuilder: (context, index) {
              return getResultItemWidget(
                context: context,
                data: sbdbCadBody.data![index],
              );
            },
          ),
        );
      },
    );
  }

  Widget getResultItemWidget({
    required BuildContext context,
    required SbdbCadData data,
  }) {
    return getResultItemContainer(
      context: context,
      child: getResultItemBody(context: context, data: data),
    );
  }

  Widget getResultItemContainer({
    required BuildContext context,
    required Widget child,
  }) {
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

  Widget getResultItemBody({
    required BuildContext context,
    required SbdbCadData data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getResultItemWrap(
          context: context,
          label: 'Desgination:',
          displayValue: data.des,
        ),
        getResultItemWrap(
          context: context,
          label: 'Close Approach Time:',
          displayValue: data.cd,
        ),
        getResultItemWrap(
          context: context,
          label: 'Distance:',
          displayValue: data.dist,
        ),
      ],
    );
  }

  Widget getResultItemWrap({
    required BuildContext context,
    required String label,
    required String displayValue,
  }) {
    return Wrap(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          displayValue,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
