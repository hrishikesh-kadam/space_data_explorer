import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/src/services/ssd_cneos/data/signature.dart';

part 'sbdb_cad_body.freezed.dart';
part 'sbdb_cad_body.g.dart';

@freezed
class SbdbCadBody with _$SbdbCadBody {
  factory SbdbCadBody.two00({
    required Signature signature,
    required int count,
  }) = SbdbCad200Body;

  factory SbdbCadBody.four00({
    required String message,
    required String moreInfo,
    required String code,
  }) = SbdbCad400Body;

  factory SbdbCadBody.fromJson(Map<String, dynamic> json) =>
      _$SbdbCadBodyFromJson(json);
}
