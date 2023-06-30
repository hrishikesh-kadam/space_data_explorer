
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sbdb_cad_data.freezed.dart';
part 'sbdb_cad_data.g.dart';

@freezed
class SbdbCadData with _$SbdbCadData {
  factory SbdbCadData(
    
  ) = _SbdbCadData;
	
  factory SbdbCadData.fromJson(Map<String, dynamic> json) =>
			_$SbdbCadDataFromJson(json);
}
