// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sbdb_cad_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SbdbCad200Data _$$SbdbCad200DataFromJson(Map<String, dynamic> json) =>
    _$SbdbCad200Data(
      Signature.fromJson(json['signature'] as Map<String, dynamic>),
      json['count'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad200DataToJson(_$SbdbCad200Data instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$SbdbCad400Data _$$SbdbCad400DataFromJson(Map<String, dynamic> json) =>
    _$SbdbCad400Data(
      json['message'] as String,
      json['moreInfo'] as String,
      json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad400DataToJson(_$SbdbCad400Data instance) =>
    <String, dynamic>{
      'message': instance.message,
      'moreInfo': instance.moreInfo,
      'code': instance.code,
      'runtimeType': instance.$type,
    };
