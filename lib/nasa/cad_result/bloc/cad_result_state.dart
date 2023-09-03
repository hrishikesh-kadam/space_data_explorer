import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_result_state.freezed.dart';

@freezed
class CadResultState with _$CadResultState {
  factory CadResultState({
    required SbdbCadBody sbdbCadBody,
  }) = _CadResultState;
}
