import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../config/config.dart';
import '../../constants/localisation.dart';
import '../../globals.dart';
import '../../typedef/typedef.dart';
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
        appBar: getPlatformSpecificAppBar(
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
            return TextButton(
              onPressed: state is CadRequestSent
                  ? null
                  : () async {
                      context.read<CadBloc>().add(const CadRequested());
                    },
              child: const Text(AppLocalisations.search),
            );
          },
        ),
      ),
    );
  }
}
