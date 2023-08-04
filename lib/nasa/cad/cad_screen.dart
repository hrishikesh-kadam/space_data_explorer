import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
import '../../widgets/choice_chip_query_widget.dart';
import '../../widgets/date_filter_widget.dart';
import '../../widgets/query_grid_container.dart';
import '../cad_result/cad_result_route.dart';
import '../widgets/choice_chip_input_widget.dart';
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
  static const Key searchButtonKey = Key('${keyPrefix}search_button_key');
  static const Key queryGridKey = Key('${keyPrefix}query_grid_key');
  static const Key dateFilterWidgetKey =
      Key('$keyPrefix${DateFilterWidget.defaultKey}');
  static const Key minDateKey = Key('$keyPrefix${DateFilterWidget.minDateKey}');
  static const Key maxDateKey = Key('$keyPrefix${DateFilterWidget.maxDateKey}');
  static const Key selectDateRangeButtonKey =
      Key('$keyPrefix${DateFilterWidget.selectDateRangeButtonKey}');
  static const String smallBodyFilterKeyPrefix = '${keyPrefix}small_body_';
  static const String closeApproachBodySelectorKeyPrefix =
      '${keyPrefix}close_approach_body_';
  static final List<SmallBody> smallBodyList = [
    SmallBody.neo,
    SmallBody.pha,
    SmallBody.nea,
    SmallBody.comet,
    SmallBody.neaComet,
  ];
  static final List<CloseApproachBody> closeApproachBodyList = [
    CloseApproachBody.earth,
    CloseApproachBody.moon,
    CloseApproachBody.all,
    CloseApproachBody.mercury,
    CloseApproachBody.venus,
    CloseApproachBody.mars,
    CloseApproachBody.jupiter,
    CloseApproachBody.saturn,
    CloseApproachBody.uranus,
    CloseApproachBody.neptune,
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
                  _getQueryGrid(context: context),
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

  Widget _getQueryGrid({
    required BuildContext context,
  }) {
    List<Widget> queryWidgetList = [
      _getDateFilterWidget(context: context),
      _getSmallBodyFilterWidget(context: context),
      _getSmallBodySelectorWidget(context: context),
      _getCloseApproachBodySelectorWidget(context: context),
      const QueryItemContainer(child: SizedBox(height: 100)),
      const QueryItemContainer(child: SizedBox(height: 150)),
      const QueryItemContainer(child: SizedBox(height: 100)),
    ];
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double whiteSpaceWhenTwo = deviceWidth -
        2 * Dimensions.cadQueryItemExtent -
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
          Dimensions.cadQueryItemExtent -
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
        key: queryGridKey,
        crossAxisCount: crossAxisCount,
        childCount: queryWidgetList.length,
        itemBuilder: (context, index) {
          return queryWidgetList[index];
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
      spacing: Dimensions.cadQueryItemSpacing,
      l10n: l10n,
      onDateRangeSelected: (dateRange) {
        context.read<CadBloc>().add(CadDateRangeSelected(
              dateRange: dateRange,
            ));
      },
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
    final List<String> keys = smallBodyList.map((e) => e.name).toList();
    assert(smallBodyList.length == chipLabels.length);
    assert(smallBodyList.length == keys.length);
    return BlocSelector<CadBloc, CadState, SmallBody>(
      selector: (state) {
        return state.smallBody;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<SmallBody>(
          keyPrefix: smallBodyFilterKeyPrefix,
          title: l10n.smallBodyFilter,
          values: smallBodyList,
          labels: chipLabels,
          keys: keys,
          selected: state,
          spacing: Dimensions.cadQueryItemSpacing,
          onChipSelected: (smallBody) {
            context.read<CadBloc>().add(CadSmallBodySelected(
                  smallBody: smallBody,
                ));
          },
        );
      },
    );
  }

  Widget _getSmallBodySelectorWidget({
    required BuildContext context,
  }) {
    const Set<SmallBodySelector> values = {
      SmallBodySelector.spkId,
      SmallBodySelector.designation,
    };
    final Set<String> labels = values.map((e) => e.displayName).toSet();
    final List<TextInputType> keyboardTypes = [
      TextInputType.number,
      TextInputType.text,
    ];
    final List<List<TextInputFormatter>?> inputFormattersList = [
      [FilteringTextInputFormatter.digitsOnly],
      null
    ];
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.smallBodySelector != current.smallBodySelector ||
            previous.spkId != current.spkId ||
            previous.designation != current.designation;
      },
      builder: (context, state) {
        final cadBloc = context.read<CadBloc>();
        return ChoiceChipInputWidget<SmallBodySelector>(
          title: l10n.smallBodySelector,
          values: values,
          labels: labels,
          selected: state.smallBodySelector,
          keyboardTypes: keyboardTypes,
          inputFormattersList: inputFormattersList,
          textFieldTextAlign: TextAlign.center,
          textFieldWidth: Dimensions.smallBodySelectorInputWidth,
          spacing: Dimensions.cadQueryItemSpacing,
          onChipSelected: (smallBodySelector) {
            cadBloc.add(CadSmallBodySelectorEvent(
              smallBodySelector: smallBodySelector,
              spkId: state.spkId,
              designation: state.designation,
            ));
          },
          onTextChanged: (value) {
            int? spkId = state.spkId;
            String? designation = state.designation;
            switch (state.smallBodySelector!) {
              case SmallBodySelector.spkId:
                spkId = value.isNotEmpty ? int.parse(value) : null;
              case SmallBodySelector.designation:
                designation = value.isNotEmpty ? value : null;
            }
            cadBloc.add(CadSmallBodySelectorEvent(
              smallBodySelector: state.smallBodySelector,
              spkId: spkId,
              designation: designation,
            ));
          },
        );
      },
    );
  }

  Widget _getCloseApproachBodySelectorWidget({
    required BuildContext context,
  }) {
    final List<String> chipLabels = [
      l10n.earth,
      l10n.moon,
      l10n.all,
      l10n.mercury,
      l10n.venus,
      l10n.mars,
      l10n.jupiter,
      l10n.saturn,
      l10n.uranus,
      l10n.neptune,
    ];
    final List<String> keys = closeApproachBodyList.map((e) => e.name).toList();
    assert(closeApproachBodyList.length == chipLabels.length);
    assert(closeApproachBodyList.length == keys.length);
    return BlocSelector<CadBloc, CadState, CloseApproachBody>(
      selector: (state) {
        return state.closeApproachBody;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<CloseApproachBody>(
          keyPrefix: closeApproachBodySelectorKeyPrefix,
          title: l10n.closeApproachBodySelector,
          values: closeApproachBodyList,
          labels: chipLabels,
          keys: keys,
          selected: state,
          spacing: Dimensions.cadQueryItemSpacing,
          onChipSelected: (closeApproachBody) {
            context.read<CadBloc>().add(CadCloseApproachBodySelected(
                  closeApproachBody: closeApproachBody,
                ));
          },
        );
      },
    );
  }
}
