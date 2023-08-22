import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../route/settings/bloc/settings_bloc.dart';
import '../../route/settings/bloc/settings_state.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_chip_query_widget.dart';
import '../../widgets/date_filter_widget.dart';
import '../../widgets/filter_chip_query_widget.dart';
import '../../widgets/query_grid_container.dart';
import '../../widgets/value_range_filter_widget.dart';
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
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key searchButtonKey = Key('${keyPrefix}search_button_key');
  static const Key queryGridKey = Key('${keyPrefix}query_grid_key');
  static const String dateFilterKeyPrefix =
      '$keyPrefix${DateFilterWidget.defaultKey}_';
  static const Key dateFilterWidgetKey =
      Key('$keyPrefix${DateFilterWidget.defaultKey}');
  static int get dateMaxDaysDefault =>
      SbdbCadQueryParameters.dateMaxDefault.difference(DateTime.now()).inDays;
  static const String distFilterKeyPrefix = '${keyPrefix}distance_filter_';
  static const Key distFilterKey =
      Key('$distFilterKeyPrefix${ValueRangeFilterWidget.defaultKey}');
  static final Set<DistanceUnit> distFilterUnits = {
    DistanceUnit.au,
    DistanceUnit.ld,
  };
  static const String smallBodyFilterKeyPrefix =
      '${keyPrefix}small_body_filter_';
  static const Key smallBodyFilterKey =
      Key('$smallBodyFilterKeyPrefix${ChoiceChipQueryWidget.defaultKey}');
  static const Set<SmallBodyFilter> smallBodySet = {
    SmallBodyFilter.neo,
    SmallBodyFilter.pha,
    SmallBodyFilter.nea,
    SmallBodyFilter.comet,
    SmallBodyFilter.neaComet,
  };
  static const String smallBodySelectorKeyPrefix =
      '${keyPrefix}small_body_selector_';
  static const Key smallBodySelectorKey =
      Key('$smallBodySelectorKeyPrefix${ChoiceChipInputWidget.defaultKey}');
  static const Set<SmallBodySelector> smallBodySelectors = {
    SmallBodySelector.spkId,
    SmallBodySelector.designation,
  };
  static final List<TextInputType> smallBodySelectorKeyboardTypes = [
    TextInputType.number,
    TextInputType.text,
  ];
  static const String closeApproachBodySelectorKeyPrefix =
      '${keyPrefix}close_approach_body_';
  static const Key closeApproachBodySelectorKey = Key(
      '$closeApproachBodySelectorKeyPrefix${ChoiceChipQueryWidget.defaultKey}');
  static const Set<CloseApproachBody> closeApproachBodySet = {
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
  };
  static const String dataOutputKeyPrefix = '${keyPrefix}data_output_';
  static const Key dataOutputKey =
      Key('$dataOutputKeyPrefix${FilterChipQueryWidget.defaultKey}');
  static const Set<DataOutput> dataOutputSet = {
    DataOutput.totalOnly,
    DataOutput.diameter,
    DataOutput.fullname,
  };
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
                key: customScrollViewKey,
                controller: ScrollController(),
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
      _getDistFilterWidget(context: context),
      _getSmallBodyFilterWidget(context: context),
      _getSmallBodySelectorWidget(context: context),
      _getCloseApproachBodySelectorWidget(context: context),
      _getDataOutputWidget(context: context),
      const QueryItemContainer(child: SizedBox(height: 100)),
      const QueryItemContainer(child: SizedBox(height: 150)),
      const QueryItemContainer(child: SizedBox(height: 100)),
    ];
    final double deviceWidth = MediaQuery.sizeOf(context).width;
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

  Widget _getDateFilterWidget({
    required BuildContext context,
  }) {
    return BlocSelector<CadBloc, CadState, DateTimeRange?>(
      selector: (state) {
        return state.dateRange;
      },
      builder: (context, dateRange) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) {
            return previous.dateFormatPattern != current.dateFormatPattern ||
                previous.language != current.language ||
                previous.systemLocales != current.systemLocales;
          },
          builder: (context, settingsState) {
            final languageTag = Localizations.localeOf(context).toLanguageTag();
            final dateFormatPattern = settingsState.dateFormatPattern;
            final dateFormat = DateFormat(
              dateFormatPattern.pattern,
              languageTag,
            );
            final ltrLanguage = !Bidi.isRtlLanguage(languageTag);
            return DateFilterWidget(
              key: dateFilterWidgetKey,
              keyPrefix: dateFilterKeyPrefix,
              title: l10n.dateFilter,
              startTitle: ltrLanguage ? '${l10n.minimum}:' : ':${l10n.minimum}',
              endTitle: ltrLanguage ? '${l10n.maximum}:' : ':${l10n.maximum}',
              dateRange: dateRange,
              firstDate: DateTime(1900, 1, 1),
              lastDate: DateTime(2200, 12, 31),
              dateFormat: dateFormat,
              startDateTextDefault: l10n.nowToday,
              endDateTextDefault: l10n.plusSomeDays(dateMaxDaysDefault),
              selectButtonTitle: l10n.selectDateRange,
              spacing: Dimensions.cadQueryItemSpacing,
              onDateRangeSelected: (dateRange) {
                context.read<CadBloc>().add(CadDateRangeSelected(
                      dateRange: dateRange,
                    ));
              },
            );
          },
        );
      },
    );
  }

  Widget _getDistFilterWidget({
    required BuildContext context,
  }) {
    final Set<String> labels = {
      l10n.minimum,
      l10n.maximum,
    };
    const DistanceRange defaultRange = DistanceRange(
      end: SbdbCadQueryParameters.distMaxDefault,
    );
    const keyboardType = TextInputType.numberWithOptions(decimal: true);
    final inputFormatters = [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
    ];
    final Set<String> unitSymbols = distFilterUnits.map((e) {
      return e.symbol;
    }).toSet();
    return BlocSelector<CadBloc, CadState, DistanceRange>(
      selector: (state) {
        return state.distRange;
      },
      builder: (context, state) {
        return ValueRangeFilterWidget<double, DistanceUnit>(
          key: distFilterKey,
          keyPrefix: distFilterKeyPrefix,
          title: l10n.distFilter,
          labels: labels,
          range: state,
          rangeText: context.read<CadBloc>().state.distRangeText,
          defaultRange: defaultRange,
          valueParser: (text) => double.tryParse(text),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          units: distFilterUnits,
          unitSymbols: unitSymbols,
          spacing: Dimensions.cadQueryItemSpacing,
          onValueRangeChanged: (range, rangeText) {
            context.read<CadBloc>().add(CadDistRangeEvent(
                  distRange: range,
                  distRangeText: rangeText,
                ));
          },
        );
      },
    );
  }

  Widget _getSmallBodyFilterWidget({
    required BuildContext context,
  }) {
    final Set<String> labels = {
      SmallBodyFilter.neo.displayName,
      SmallBodyFilter.pha.displayName,
      SmallBodyFilter.nea.displayName,
      l10n.comet,
      l10n.neaComet,
    };
    final Set<String> keys = smallBodySet.map((e) => e.name).toSet();
    // TODO(hrishikesh-kadam): Move these asserts to widget
    assert(smallBodySet.length == labels.length);
    assert(smallBodySet.length == keys.length);
    return BlocSelector<CadBloc, CadState, SmallBodyFilterState>(
      selector: (state) {
        return state.smallBodyFilterState;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<SmallBodyFilter>(
          key: smallBodyFilterKey,
          keyPrefix: smallBodyFilterKeyPrefix,
          enabled: state.enabled,
          title: l10n.smallBodyFilter,
          values: smallBodySet,
          labels: labels,
          keys: keys,
          selected: state.smallBodyFilter,
          spacing: Dimensions.cadQueryItemSpacing,
          onChipSelected: (smallBodyFilter) {
            context.read<CadBloc>().add(CadSmallBodyFilterSelected(
                  smallBodyFilter: smallBodyFilter,
                ));
          },
        );
      },
    );
  }

  Widget _getSmallBodySelectorWidget({
    required BuildContext context,
  }) {
    final Set<String> labels =
        smallBodySelectors.map((e) => e.displayName).toSet();
    final Set<String> keys = smallBodySelectors.map((e) => e.name).toSet();
    final List<List<TextInputFormatter>?> inputFormattersList = [
      [FilteringTextInputFormatter.digitsOnly],
      null
    ];
    return BlocSelector<CadBloc, CadState, SmallBodySelectorState>(
      selector: (state) {
        return state.smallBodySelectorState;
      },
      builder: (context, state) {
        return ChoiceChipInputWidget<SmallBodySelector>(
          key: smallBodySelectorKey,
          keyPrefix: smallBodySelectorKeyPrefix,
          title: l10n.smallBodySelector,
          values: smallBodySelectors,
          labels: labels,
          keys: keys,
          selected: state.smallBodySelector,
          textList: [
            state.spkId?.toString() ?? '',
            state.designation?.toString() ?? '',
          ],
          keyboardTypes: smallBodySelectorKeyboardTypes,
          inputFormattersList: inputFormattersList,
          textFieldWidth: Dimensions.smallBodySelectorInputWidth,
          spacing: Dimensions.cadQueryItemSpacing,
          onStateChanged: (value, textList) {
            int? spkId = textList[0].isNotEmpty ? int.parse(textList[0]) : null;
            String? designation = textList[1].isNotEmpty ? textList[1] : null;
            context.read<CadBloc>().add(CadSmallBodySelectorEvent(
                  smallBodySelectorState: SmallBodySelectorState(
                    smallBodySelector: value,
                    spkId: spkId,
                    designation: designation,
                  ),
                ));
          },
        );
      },
    );
  }

  Widget _getCloseApproachBodySelectorWidget({
    required BuildContext context,
  }) {
    final Set<String> labels = {
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
    };
    final Set<String> keys = closeApproachBodySet.map((e) => e.name).toSet();
    assert(closeApproachBodySet.length == labels.length);
    assert(closeApproachBodySet.length == keys.length);
    return BlocSelector<CadBloc, CadState, CloseApproachBody>(
      selector: (state) {
        return state.closeApproachBody;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<CloseApproachBody>(
          key: closeApproachBodySelectorKey,
          keyPrefix: closeApproachBodySelectorKeyPrefix,
          title: l10n.closeApproachBodySelector,
          values: closeApproachBodySet,
          labels: labels,
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

  _getDataOutputWidget({
    required BuildContext context,
  }) {
    final Set<String> labels = {
      l10n.totalOnly,
      l10n.diameter,
      l10n.fullname,
    };
    final Set<String> keys = dataOutputSet.map((e) => e.name).toSet();
    assert(dataOutputSet.length == labels.length);
    assert(dataOutputSet.length == keys.length);
    return BlocSelector<CadBloc, CadState, Set<DataOutput>>(
      selector: (state) {
        return state.dataOutputSet;
      },
      builder: (context, state) {
        return FilterChipQueryWidget<DataOutput>(
          key: dataOutputKey,
          keyPrefix: dataOutputKeyPrefix,
          title: l10n.dataOutput,
          values: dataOutputSet,
          labels: labels,
          keys: keys,
          selected: state,
          spacing: Dimensions.cadQueryItemSpacing,
          onChipsSelected: (dataOutputSet) {
            context.read<CadBloc>().add(CadDataOutputEvent(
                  dataOutputSet: dataOutputSet,
                ));
          },
        );
      },
    );
  }
}
