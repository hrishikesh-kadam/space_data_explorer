// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sbdb_cad_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SbdbCad2xxResponse _$$SbdbCad2xxResponseFromJson(Map<String, dynamic> json) =>
    _$SbdbCad2xxResponse(
      Signature.fromJson(json['signature'] as Map<String, dynamic>),
      json['count'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad2xxResponseToJson(
        _$SbdbCad2xxResponse instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$SbdbCad4xxResponse _$$SbdbCad4xxResponseFromJson(Map<String, dynamic> json) =>
    _$SbdbCad4xxResponse(
      json['message'] as String,
      json['moreInfo'] as String,
      json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SbdbCad4xxResponseToJson(
        _$SbdbCad4xxResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'moreInfo': instance.moreInfo,
      'code': instance.code,
      'runtimeType': instance.$type,
    };
