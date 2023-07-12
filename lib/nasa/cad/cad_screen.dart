import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../config/config.dart';
import '../../globals.dart';
import '../../typedef/typedef.dart';
import '../../widgets/date_filter_widget.dart';
import 'bloc/cad_bloc.dart';
import 'cad_route.dart';
import 'result/cad_result_route.dart';

class CadScreen extends StatelessWidget {
  const CadScreen({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CadBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: getAppBarBackButton(context: context),
          title: const Text(CadRoute.displayName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
