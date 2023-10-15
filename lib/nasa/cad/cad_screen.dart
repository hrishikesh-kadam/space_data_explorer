import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import '../../config/config.dart';
import '../../constants/dimensions.dart';
import '../../constants/labels.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import '../../route/home/home_route.dart';
import '../../route/settings/bloc/settings_bloc.dart';
import '../../route/settings/bloc/settings_state.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_chip_input_widget.dart';
import '../../widgets/choice_chip_query_widget.dart';
import '../../widgets/date_filter_widget.dart';
import '../../widgets/filter_chip_query_widget.dart';
import '../../widgets/outlined_button_extended.dart';
import '../../widgets/value_range_filter_widget.dart';
import '../cad_result/cad_result_route.dart';
import 'bloc/cad_bloc.dart';
import 'bloc/cad_state.dart';

class CadScreen extends StatelessWidget {
  CadScreen({
    super.key,
    required this.title,
    required this.l10n,
    this.routeExtraMap,
  });

  final String title;
  final AppLocalizations l10n;
  final JsonMap? routeExtraMap;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.CadScreen');
  static const String keyPrefix = 'cad_screen_';
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key searchButtonKey = Key('${keyPrefix}search_button_key');
  static const Key queryGridKey = Key('${keyPrefix}query_grid_key');
  static const String dateFilterKeyPrefix =
      '$keyPrefix${DateFilterWidget.defaultKey}_';
  static const Key dateFilterWidgetKey =
      Key('$keyPrefix${DateFilterWidget.defaultKey}');
  static int get dateMaxDaysDefault => SbdbCadQueryParameters.dateMaxDefault
      .difference(HrkDateTime.today())
      .inDays;
  static const String distFilterKeyPrefix = '${keyPrefix}distance_filter_';
  static const Key distFilterKey =
      Key('$distFilterKeyPrefix${ValueRangeFilterWidget.defaultKey}');
  // deliberately set as final instead of const for testing
  static final Set<DistanceUnit> distFilterUnits = {
    DistanceUnit.au,
    DistanceUnit.LD,
  };
  static const String smallBodyFilterKeyPrefix =
      '${keyPrefix}small_body_filter_';
  static const Key smallBodyFilterKey =
      Key('$smallBodyFilterKeyPrefix${ChoiceChipQueryWidget.defaultKey}');
  static const Set<SmallBodyFilter> smallBodyFilterSet = {
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
  // deliberately set as final instead of const for testing
  static final List<TextInputType> smallBodySelectorKeyboardTypes = [
    TextInputType.number,
    TextInputType.text,
  ];
  static const String closeApproachBodySelectorKeyPrefix =
      '${keyPrefix}close_approach_body_';
  static const Key closeApproachBodySelectorKey = Key(
      '$closeApproachBodySelectorKeyPrefix${ChoiceChipQueryWidget.defaultKey}');
  static final Set<CloseApproachBody> closeApproachBodySet = {
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
    if (!prodRelease) CloseApproachBody.pluto,
  };
  static const String dataOutputKeyPrefix = '${keyPrefix}data_output_';
  static const Key dataOutputKey =
      Key('$dataOutputKeyPrefix${FilterChipQueryWidget.defaultKey}');
  static const Set<DataOutput> dataOutputSet = {
    DataOutput.totalOnly,
    DataOutput.diameter,
    DataOutput.fullname,
  };
  static const Key snackBarKey = Key('${keyPrefix}snack_bar');
  // To inject during deep-link, see pumpCadRouteAsInitialLocation()
  @visibleForTesting
  static CadBloc? cadBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadBloc>(
      create: (_) => cadBloc ?? routeExtraMap?['$CadBloc'] ?? CadBloc(),
      child: _getCadBlocListener(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppTheme.pageBackgroundColor,
              body: _getBody(context: context),
            );
          },
        ),
      ),
    );
  }

  Widget _getCadBlocListener({required Widget child}) {
    return BlocListener<CadBloc, CadState>(
      listenWhen: (previous, current) {
        return previous.networkState != current.networkState &&
            (current.networkState == NetworkState.success ||
                current.networkState == NetworkState.failure);
      },
      listener: (context, state) {
        if (state.networkState == NetworkState.success) {
          JsonMap routeExtraMap = getRouteExtraMap();
          routeExtraMap['$SbdbCadBody'] = state.sbdbCadBody!;
          CadResultRoute($extra: routeExtraMap).go(context);
          context.read<CadBloc>().add(const CadResultOpened());
        } else if (state.networkState == NetworkState.failure) {
          String errorString = Labels.somethingWentWrong;
          if (state.error is DioException) {
            final dioException = state.error as DioException;
            if (dioException.type == DioExceptionType.badResponse) {
              final statusCodeInt = dioException.response?.statusCode;
              errorString += '\n${Labels.statusCode}: $statusCodeInt';
              if (dioException.response?.data is JsonMap) {
                errorString +=
                    '\n${jsonEncoderPretty.convert(dioException.response!.data)}';
              }
            } else {
              errorString = dioException.type.name.sentenceCase;
            }
          }
          final snackBar = SnackBar(
            key: snackBarKey,
            content: Text(errorString),
          );
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(snackBar);
        }
      },
      child: child,
    );
  }

  Widget _getBody({required BuildContext context}) {
    return CustomScrollView(
      key: customScrollViewKey,
      controller: ScrollController(),
      slivers: [
        getSliverAppBar(
          context: context,
          title: Tooltip(
            message: title,
            child: Text(title),
          ),
          floating: true,
          snap: true,
        ),
        ..._getSliverBody(context: context),
      ],
    );
  }

  List<Widget> _getSliverBody({required BuildContext context}) {
    return [
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
        ),
      ),
      _getSearchButton(context: context),
      _getQueryGrid(context: context),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
        ),
      )
    ];
  }

  Widget _getSearchButton({required BuildContext context}) {
    return BlocSelector<CadBloc, CadState, NetworkState>(
      selector: (state) {
        return state.networkState;
      },
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.pagePaddingHorizontal,
            vertical: Dimensions.pagePaddingVertical,
          ),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: OutlinedButtonExtended(
                key: searchButtonKey,
                label: Text(
                  l10n.search,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                networkState: state,
                onPressed: () async {
                  // throw Exception();
                  context.read<CadBloc>().add(const CadRequested());
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getQueryGrid({required BuildContext context}) {
    final List<Widget> queryWidgetList = [
      _getDateFilterWidget(context: context),
      _getDistFilterWidget(context: context),
      _getSmallBodyFilterWidget(context: context),
      _getSmallBodySelectorWidget(context: context),
      _getCloseApproachBodySelectorWidget(context: context),
      _getDataOutputWidget(context: context),
    ];
    final gridParameters = getSliverMasonryGridParameters(
      context: context,
      itemExtent: Dimensions.cadQueryItemExtent,
      pagePaddingHorizontal: Dimensions.pagePaddingHorizontal,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: gridParameters.$1,
      ),
      sliver: SliverMasonryGrid.count(
        key: queryGridKey,
        crossAxisCount: gridParameters.$2,
        childCount: queryWidgetList.length,
        itemBuilder: (context, index) {
          return queryWidgetList[index];
        },
      ),
    );
  }

  Widget _getDateFilterWidget({required BuildContext context}) {
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.dateRange != current.dateRange ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, cadState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) {
            return previous.dateFormatPattern != current.dateFormatPattern ||
                previous.locale != current.locale;
          },
          builder: (context, settingsState) {
            final localeString = Localizations.localeOf(context).toString();
            final dateFormatPattern = settingsState.dateFormatPattern;
            final dateFormat = DateFormat(
              dateFormatPattern.pattern,
              localeString,
            );
            return DateFilterWidget(
              key: dateFilterWidgetKey,
              keyPrefix: dateFilterKeyPrefix,
              title: l10n.dateFilter,
              startTitle: '${l10n.minimum}:',
              endTitle: '${l10n.maximum}:',
              dateRange: cadState.dateRange,
              firstDate: DateTime(1900, 1, 1),
              lastDate: DateTime(2200, 12, 31),
              dateFormat: dateFormat,
              startDateTextDefault: l10n.nowToday,
              endDateTextDefault: l10n.plusSomeDays(dateMaxDaysDefault),
              selectButtonTitle: l10n.selectDateRange,
              disableInputs: cadState.disableInputs,
              spacing: Dimensions.cadQueryItemSpacing,
              onDateRangeSelected: (dateRange) {
                if (context.mounted) {
                  context.read<CadBloc>().add(CadDateRangeSelected(
                        dateRange: dateRange,
                      ));
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _getDistFilterWidget({required BuildContext context}) {
    final Set<String> labels = {
      l10n.minimum,
      l10n.maximum,
    };
    const keyboardType = TextInputType.numberWithOptions(decimal: true);
    final inputFormatters = [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
    ];
    final Set<String> unitSymbols = distFilterUnits.map((e) {
      return e.symbol;
    }).toSet();
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.distanceRangeState != current.distanceRangeState ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, state) {
        return ValueRangeFilterWidget<double, DistanceUnit>(
          key: distFilterKey,
          keyPrefix: distFilterKeyPrefix,
          title: l10n.distFilter,
          labels: labels,
          valueList: state.distanceRangeState.valueList,
          textList: state.distanceRangeState.textList,
          unitList: state.distanceRangeState.unitList,
          defaultValueList: DistanceRangeState.valueListDefault,
          defaultUnitList: DistanceRangeState.unitListDefault,
          valueParser: (text) => double.tryParse(text),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          units: distFilterUnits,
          unitSymbols: unitSymbols,
          disableInputs: state.disableInputs,
          spacing: Dimensions.cadQueryItemSpacing,
          onValueRangeChanged: (valueList, textList, unitList) {
            context.read<CadBloc>().add(CadDistanceEvent(
                  valueList: valueList,
                  textList: textList,
                  unitList: unitList!,
                ));
          },
        );
      },
    );
  }

  Widget _getSmallBodyFilterWidget({required BuildContext context}) {
    final Set<String> labels = {
      SmallBodyFilter.neo.displayName,
      SmallBodyFilter.pha.displayName,
      SmallBodyFilter.nea.displayName,
      l10n.comet,
      l10n.neaComet,
    };
    final Set<String> keys = smallBodyFilterSet.map((e) => e.name).toSet();
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.smallBodyFilterState != current.smallBodyFilterState ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<SmallBodyFilter>(
          key: smallBodyFilterKey,
          keyPrefix: smallBodyFilterKeyPrefix,
          enabled: state.smallBodyFilterState.enabled,
          title: l10n.smallBodyFilter,
          values: smallBodyFilterSet,
          labels: labels,
          keys: keys,
          selected: state.smallBodyFilterState.smallBodyFilter,
          disableInputs: state.disableInputs,
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

  Widget _getSmallBodySelectorWidget({required BuildContext context}) {
    final Set<String> labels = {
      SmallBodySelector.spkId.displayName,
      l10n.designation,
    };
    final Set<String> keys = smallBodySelectors.map((e) => e.name).toSet();
    final List<List<TextInputFormatter>?> inputFormattersList = [
      [FilteringTextInputFormatter.digitsOnly],
      null
    ];
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.smallBodySelectorState !=
                current.smallBodySelectorState ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, state) {
        return ChoiceChipInputWidget<SmallBodySelector>(
          key: smallBodySelectorKey,
          keyPrefix: smallBodySelectorKeyPrefix,
          title: l10n.smallBodySelector,
          values: smallBodySelectors,
          labels: labels,
          keys: keys,
          selected: state.smallBodySelectorState.smallBodySelector,
          textList: [
            state.smallBodySelectorState.spkId?.toString() ?? '',
            state.smallBodySelectorState.designation?.toString() ?? '',
          ],
          keyboardTypes: smallBodySelectorKeyboardTypes,
          inputFormattersList: inputFormattersList,
          textFieldWidth: Dimensions.smallBodySelectorInputWidth,
          disableInputs: state.disableInputs,
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

  Widget _getCloseApproachBodySelectorWidget({required BuildContext context}) {
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
      if (!prodRelease) l10n.pluto,
    };
    final Set<String> keys = closeApproachBodySet.map((e) => e.name).toSet();
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.closeApproachBody != current.closeApproachBody ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, state) {
        return ChoiceChipQueryWidget<CloseApproachBody>(
          key: closeApproachBodySelectorKey,
          keyPrefix: closeApproachBodySelectorKeyPrefix,
          title: l10n.closeApproachBodySelector,
          values: closeApproachBodySet,
          labels: labels,
          keys: keys,
          selected: state.closeApproachBody,
          disableInputs: state.disableInputs,
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

  _getDataOutputWidget({required BuildContext context}) {
    final Set<String> labels = {
      l10n.totalOnly,
      l10n.diameter,
      l10n.fullname,
    };
    final Set<String> keys = dataOutputSet.map((e) => e.name).toSet();
    return BlocBuilder<CadBloc, CadState>(
      buildWhen: (previous, current) {
        return previous.dataOutputSet != current.dataOutputSet ||
            previous.disableInputs != current.disableInputs;
      },
      builder: (context, state) {
        return FilterChipQueryWidget<DataOutput>(
          key: dataOutputKey,
          keyPrefix: dataOutputKeyPrefix,
          title: l10n.dataOutput,
          values: dataOutputSet,
          labels: labels,
          keys: keys,
          selected: state.dataOutputSet,
          disableInputs: state.disableInputs,
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
