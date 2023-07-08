import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/config.dart';
import '../../constants/localisation.dart';
import '../../globals.dart';
import 'bloc/cad_bloc.dart';
import 'cad_page.dart';
import 'result/cad_result_page.dart';

class CadScreen extends StatelessWidget {
  const CadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CadBloc(),
      child: Scaffold(
        appBar: getPlatformSpecificAppBar(
          context: context,
          title: const Text(CadPage.displayName),
        ),
        body: BlocConsumer<CadBloc, CadState>(
          listener: (context, state) {
            if (state is CadRequestSuccess) {
              GoRouter.of(context)
                  .go(CadResultPage.path, extra: getPageExtra());
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
