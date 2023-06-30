import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/signature.dart';

part 'sbdb_cad_data.freezed.dart';
part 'sbdb_cad_data.g.dart';

@freezed
class SbdbCadData with _$SbdbCadData {
  factory SbdbCadData.two00(
    Signature signature,
    int count,
  ) = SbdbCad200Data;

  factory SbdbCadData.four00(
    String message,
    String moreInfo,
    String code,
  ) = SbdbCad400Data;

  factory SbdbCadData.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadDataFromJson(json);
}
