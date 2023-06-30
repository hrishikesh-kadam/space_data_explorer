import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/data/signature.dart';

part 'sbdb_cad_body.freezed.dart';
part 'sbdb_cad_body.g.dart';

@freezed
class SbdbCadBody with _$SbdbCadBody {
  factory SbdbCadBody.two00(
    Signature signature,
    int count,
  ) = SbdbCad200Body;

  factory SbdbCadBody.four00(
    String message,
    String moreInfo,
    String code,
  ) = SbdbCad400Body;

  factory SbdbCadBody.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadBodyFromJson(json);
}
