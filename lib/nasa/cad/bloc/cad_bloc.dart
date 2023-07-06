import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cad_event.dart';
part 'cad_state.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc() : super(CadInitial()) {
    on<CadEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
