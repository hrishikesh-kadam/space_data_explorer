import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:meta/meta.dart';

import '../../../constants/constants.dart';

part 'cad_event.dart';
part 'cad_state.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc() : super(CadInitial()) {
    on<CadRequested>(_onCadRequested);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  final _sbdbCadApi = SbdbCadApi();

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(CadRequestSent());
    try {
      Response<SbdbCadBody> response = await _sbdbCadApi.get();
      _log.debug('_onCadRequested success');
      emit(CadRequestSuccess(sbdbCadBody: response.data!));
    } on Exception catch (e) {
      _log.error('_onCadRequested failed\n$e');
      emit(CadRequestFailure());
    }
  }
}
