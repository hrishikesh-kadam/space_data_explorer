import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../constants/constants.dart';
import '../../globals.dart';
import '../../widgets/app_bar.dart';
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
  static const String keyPrefix = 'cad_screen_';
  static const Key searchButtonKey = Key('${keyPrefix}search_button');
  static const Key minDateKey = Key('$keyPrefix${DateFilterWidget.minDateKey}');
  static const Key maxDateKey = Key('$keyPrefix${DateFilterWidget.maxDateKey}');
  static const Key selectDateRangeButtonKey =
      Key('$keyPrefix${DateFilterWidget.selectDateRangeButtonKey}');
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.CadScreen');
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
    return Column(
      children: [
        _getSearchButton(context: context),
        _getDateFilterWidget(context: context),
      ],
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
          onPressed: state == NetworkState.sent
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
    );
  }
}
