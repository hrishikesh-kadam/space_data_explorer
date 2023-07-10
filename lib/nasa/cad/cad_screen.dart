import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../config/config.dart';
import '../../constants/localisation.dart';
import '../../globals.dart';
import '../../typedef/typedef.dart';
import '../../widgets/date_filter_widget.dart';
import 'bloc/cad_bloc.dart';
import 'cad_route.dart';
import 'result/cad_result_route.dart';

class CadScreen extends StatelessWidget {
  const CadScreen({super.key});

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
            return Column(
              children: [
                SearchButton(cadState: state),
                const DateFilterWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  SearchButton({
    super.key,
    required CadState cadState,
  }) {
    _cadState = cadState;
  }

  late final CadState _cadState;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: _cadState is CadRequestSent
            ? null
            : () async {
                context.read<CadBloc>().add(const CadRequested());
              },
        // style: ButtonStyle(),
        child: const Text(AppLocalisations.search));
  }
}
