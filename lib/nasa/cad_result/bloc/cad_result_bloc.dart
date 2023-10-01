import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'cad_result_state.dart';

part 'cad_result_event.dart';

class CadResultBloc extends Bloc<CadResultEvent, CadResultState> {
  CadResultBloc({
    required SbdbCadBody sbdbCadBody,
  }) : super(CadResultState(
          sbdbCadBody: sbdbCadBody,
        )) {
    on<CadResultEvent>((event, emit) {});
  }
}
