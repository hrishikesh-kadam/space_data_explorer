import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_chip_filter_widget.dart';
import '../../widgets/date_filter_widget.dart';
import '../../widgets/filter_container.dart';
import '../cad_result/cad_result_route.dart';
import 'bloc/cad_bloc.dart';
import 'bloc/cad_state.dart';
import 'cad_route.dart';

class CadScreen extends StatelessWidget {
  CadScreen({
    super.key,
    required this.l10n,
    this.routeExtraMap,
  });

  final AppLocalizations l10n;
  final JsonMap? routeExtraMap;
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.CadScreen');
  static const String keyPrefix = 'cad_screen_';
  static const Key searchButtonKey = Key('${keyPrefix}search_button');
  static const Key queryFilterGridKey = Key('${keyPrefix}query_filter_grid');
  static const Key dateFilterWidgetKey =
      Key('$keyPrefix${DateFilterWidget.defaultKey}');
  static const Key minDateKey = Key('$keyPrefix${DateFilterWidget.minDateKey}');
  static const Key maxDateKey = Key('$keyPrefix${DateFilterWidget.maxDateKey}');
  static const Key selectDateRangeButtonKey =
      Key('$keyPrefix${DateFilterWidget.selectDateRangeButtonKey}');
  static final List<SmallBody> smallBodyList = [
    SmallBody.neo,
    SmallBody.pha,
    SmallBody.nea,
    SmallBody.comet,
    SmallBody.neaComet,
  ];
  // To inject during deep-link, see pumpCadRouteAsInitialLocation()
  @visibleForTesting
  static CadBloc? cadBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadBloc>(
      create: (_) => cadBloc ?? routeExtraMap?['$CadBloc'] ?? CadBloc(),
      child: Scaffold(
        backgroundColor: AppTheme.pageBackgroundColor,
        body: BlocListener<CadBloc, CadState>(
          listenWhen: (previous, current) {
            return previous.networkState != current.networkState &&
                current.networkState == NetworkState.success;
          },
          listener: (context, state) {
            JsonMap routeExtraMap = getRouteExtraMap();
            routeExtraMap['$SbdbCadBody'] = state.sbdbCadBody!;
            CadResultRoute($extra: routeExtraMap).go(context);
          },
          child: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  getSliverAppBar(
                    context: context,
                    title: const Text(CadRoute.displayName),
                    floating: true,
                    snap: true,
                  ),
                  _getSearchButton(context: context),
                  _getFilterList(context: context),
                  const SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: Dimensions.pagePaddingVertical,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getSearchButton({
    required BuildContext context,
  }) {
    return BlocSelector<CadBloc, CadState, NetworkState>(
      selector: (state) {
        return state.networkState;
      },
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.pagePaddingHorizontal,
          ),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: OutlinedButton(
                key: searchButtonKey,
                onPressed: state == NetworkState.sending
                    ? null
                    : () async {
                        context.read<CadBloc>().add(const CadRequested());
                      },
                child: Text(l10n.search),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getFilterList({
    required BuildContext context,
  }) {
    List<Widget> filterWidgetList = [
      _getDateFilterWidget(context: context),
      _getSmallBodyFilterWidget(context: context),
      const QueryFilterContainer(child: SizedBox(height: 200)),
      const QueryFilterContainer(child: SizedBox(height: 100)),
      const QueryFilterContainer(child: SizedBox(height: 150)),
      const QueryFilterContainer(child: SizedBox(height: 100)),
    ];
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double whiteSpaceWhenTwo = deviceWidth -
        2 * Dimensions.cadQueryFilterExtent -
        2 * Dimensions.pagePaddingHorizontal;
    // _log.debug('deviceWidth = $deviceWidth');
    // _log.debug('whiteSpaceWhenTwo = $whiteSpaceWhenTwo');
    int crossAxisCount;
    double horizontalPadding = Dimensions.pagePaddingHorizontal;
    if (whiteSpaceWhenTwo >= 0) {
      crossAxisCount = 2;
      horizontalPadding += whiteSpaceWhenTwo / 2;
    } else {
      final double whiteSpaceWhenOne = deviceWidth -
          Dimensions.cadQueryFilterExtent -
          2 * Dimensions.pagePaddingHorizontal;
      // _log.debug('whiteSpaceWhenOne = $whiteSpaceWhenOne');
      if (whiteSpaceWhenOne >= 0) {
        crossAxisCount = 1;
        horizontalPadding += whiteSpaceWhenOne / 2;
      } else {
        crossAxisCount = 1;
      }
    }
    // _log.debug('horizontalPadding = $horizontalPadding');
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      sliver: SliverMasonryGrid.count(
        key: queryFilterGridKey,
        crossAxisCount: crossAxisCount,
        childCount: filterWidgetList.length,
        itemBuilder: (context, index) {
          return filterWidgetList[index];
        },
      ),
    );
  }

  DateFilterWidget _getDateFilterWidget({
    required BuildContext context,
  }) {
    return DateFilterWidget(
      keyPrefix: keyPrefix,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2200, 12, 31),
      onDateRangeSelected: (dateRange) {
        context.read<CadBloc>().add(CadDateRangeSelected(
              dateRange: dateRange,
            ));
      },
      l10n: l10n,
      spacing: Dimensions.cadQueryFilterSpacing,
    );
  }

  Widget _getSmallBodyFilterWidget({
    required BuildContext context,
  }) {
    final List<String> chipLabels = [
      SmallBody.neo.displayName,
      SmallBody.pha.displayName,
      SmallBody.nea.displayName,
      l10n.comet,
      l10n.neaComet,
    ];
    final List<String> keys = smallBodyList.map((e) => e.toString()).toList();
    return BlocSelector<CadBloc, CadState, SmallBody>(
      selector: (state) {
        return state.smallBody;
      },
      builder: (context, state) {
        return ChoiceChipFilterWidget<SmallBody>(
          keyPrefix: keyPrefix,
          title: l10n.smallBodyFilter,
          values: smallBodyList,
          labels: chipLabels,
          keys: keys,
          selected: state,
          onChipSelected: (smallBody) {
            context.read<CadBloc>().add(CadSmallBodySelected(
                  smallBody: smallBody,
                ));
          },
          l10n: l10n,
          spacing: Dimensions.cadQueryFilterSpacing,
        );
      },
    );
  }
}
