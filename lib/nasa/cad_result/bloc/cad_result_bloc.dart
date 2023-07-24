import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cad_result_event.dart';
part 'cad_result_state.dart';

class CadResultBloc extends Bloc<CadResultEvent, CadResultState> {
  CadResultBloc() : super(CadResultInitial()) {
    on<CadResultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
