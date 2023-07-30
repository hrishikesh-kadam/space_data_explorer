import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../constants/constants.dart';
import '../../constants/dimensions.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/choice_chip_filter_widget.dart';
import '../../widgets/date_filter_widget.dart';
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
  static const Key dateFilterWidgetKey =
      Key('$keyPrefix${DateFilterWidget.defaultKey}');
  static const Key minDateKey = Key('$keyPrefix${DateFilterWidget.minDateKey}');
  static const Key maxDateKey = Key('$keyPrefix${DateFilterWidget.maxDateKey}');
  static const Key selectDateRangeButtonKey =
      Key('$keyPrefix${DateFilterWidget.selectDateRangeButtonKey}');
  static final List<SmallBody> smallBodyList = [
    SmallBody.pha,
    SmallBody.nea,
    SmallBody.comet,
    SmallBody.neaComet,
    SmallBody.neo,
  ];
  // To inject during deep-link, see pumpCadRouteAsInitialLocation()
  @visibleForTesting
  static CadBloc? cadBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadBloc>(
      create: (_) => cadBloc ?? routeExtraMap?['$CadBloc'] ?? CadBloc(),
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: const Text(CadRoute.displayName),
        ),
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
              return _getCadScreen(context: context);
            },
          ),
        ),
      ),
    );
  }

  Widget _getCadScreen({
    required BuildContext context,
  }) {
    return Container(
      color: AppTheme.pageBackgroundColor,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          _getSearchButton(context: context),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _getDateFilterWidget(context: context),
              _getSmallBodyFilterWidget(context: context),
            ],
          ),
        ],
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
        return OutlinedButton(
          key: searchButtonKey,
          onPressed: state == NetworkState.sending
              ? null
              : () async {
                  context.read<CadBloc>().add(const CadRequested());
                },
          child: Text(l10n.search),
        );
      },
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

  ChoiceChipFilterWidget _getSmallBodyFilterWidget({
    required BuildContext context,
  }) {
    final List<String> chipLabels = [
      SmallBody.pha.displayName,
      SmallBody.nea.displayName,
      l10n.comet,
      l10n.neaComet,
      SmallBody.neo.displayName,
    ];
    final List<String> keys = smallBodyList.map((e) => e.toString()).toList();
    return ChoiceChipFilterWidget<SmallBody>(
      keyPrefix: keyPrefix,
      title: l10n.smallBodyFilter,
      values: smallBodyList,
      labels: chipLabels,
      keys: keys,
      onChipSelected: (smallBody) {
        context.read<CadBloc>().add(CadSmallBodySelected(
              smallBody: smallBody,
            ));
      },
      l10n: l10n,
      spacing: Dimensions.cadQueryFilterSpacing,
    );
  }
}
