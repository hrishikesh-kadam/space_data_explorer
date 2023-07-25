import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../constants/constants.dart';
import '../../globals.dart';
import '../../typedef/typedef.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/date_filter_widget.dart';
import '../cad_result/cad_result_route.dart';
import 'bloc/cad_bloc.dart';
import 'cad_route.dart';

class CadScreen extends StatelessWidget {
  CadScreen({
    super.key,
    required this.l10n,
    this.routeExtraMap,
  });

  final AppLocalizations l10n;
  static const Key searchButtonKey = Key('cad_screen_search_button');
  final RouteExtraMap? routeExtraMap;
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
        body: BlocConsumer<CadBloc, CadState>(
          listener: (context, state) {
            if (state is CadRequestSuccess) {
              RouteExtraMap routeExtraMap = getRouteExtra();
              routeExtraMap['$SbdbCadBody'] = state.sbdbCadBody;
              CadResultRoute($extra: routeExtraMap).go(context);
            }
          },
          builder: (context, state) {
            return _getCadScreen(context: context, cadState: state);
          },
        ),
      ),
    );
  }

  Widget _getCadScreen({
    required BuildContext context,
    required CadState cadState,
  }) {
    return Column(
      children: [
        _getSearchButton(context: context, cadState: cadState),
        _getDateFilterWidget(context: context),
      ],
    );
  }

  OutlinedButton _getSearchButton({
    required BuildContext context,
    required CadState cadState,
  }) {
    return OutlinedButton(
      key: searchButtonKey,
      onPressed: cadState is CadRequestSent
          ? null
          : () async {
              context.read<CadBloc>().add(const CadRequested());
            },
      child: Text(l10n.search),
    );
  }

  DateFilterWidget _getDateFilterWidget({
    required BuildContext context,
  }) {
    return DateFilterWidget(
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
