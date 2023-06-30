// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sbdb_cad_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SbdbCadBody _$SbdbCadBodyFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'two00':
      return SbdbCad200Body.fromJson(json);
    case 'four00':
      return SbdbCad400Body.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SbdbCadBody',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SbdbCadBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Signature signature, int count, List<SbdbCadData>? data)
        two00,
    required TResult Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)
        four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult? Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)?
        four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult Function(String message, @JsonKey(name: 'moreInfo') String moreInfo,
            String code)?
        four00,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Body value) two00,
    required TResult Function(SbdbCad400Body value) four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Body value)? two00,
    TResult? Function(SbdbCad400Body value)? four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Body value)? two00,
    TResult Function(SbdbCad400Body value)? four00,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SbdbCadBodyCopyWith<$Res> {
  factory $SbdbCadBodyCopyWith(
          SbdbCadBody value, $Res Function(SbdbCadBody) then) =
      _$SbdbCadBodyCopyWithImpl<$Res, SbdbCadBody>;
}

/// @nodoc
class _$SbdbCadBodyCopyWithImpl<$Res, $Val extends SbdbCadBody>
    implements $SbdbCadBodyCopyWith<$Res> {
  _$SbdbCadBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SbdbCad200BodyCopyWith<$Res> {
  factory _$$SbdbCad200BodyCopyWith(
          _$SbdbCad200Body value, $Res Function(_$SbdbCad200Body) then) =
      __$$SbdbCad200BodyCopyWithImpl<$Res>;
  @useResult
  $Res call({Signature signature, int count, List<SbdbCadData>? data});

  $SignatureCopyWith<$Res> get signature;
}

/// @nodoc
class __$$SbdbCad200BodyCopyWithImpl<$Res>
    extends _$SbdbCadBodyCopyWithImpl<$Res, _$SbdbCad200Body>
    implements _$$SbdbCad200BodyCopyWith<$Res> {
  __$$SbdbCad200BodyCopyWithImpl(
      _$SbdbCad200Body _value, $Res Function(_$SbdbCad200Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? count = null,
    Object? data = freezed,
  }) {
    return _then(_$SbdbCad200Body(
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as Signature,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SbdbCadData>?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SignatureCopyWith<$Res> get signature {
    return $SignatureCopyWith<$Res>(_value.signature, (value) {
      return _then(_value.copyWith(signature: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SbdbCad200Body implements SbdbCad200Body {
  _$SbdbCad200Body(
      {required this.signature,
      required this.count,
      required final List<SbdbCadData>? data,
      final String? $type})
      : _data = data,
        $type = $type ?? 'two00';

  factory _$SbdbCad200Body.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad200BodyFromJson(json);

  @override
  final Signature signature;
  @override
  final int count;
  final List<SbdbCadData>? _data;
  @override
  List<SbdbCadData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SbdbCadBody.two00(signature: $signature, count: $count, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad200Body &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signature, count,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SbdbCad200BodyCopyWith<_$SbdbCad200Body> get copyWith =>
      __$$SbdbCad200BodyCopyWithImpl<_$SbdbCad200Body>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Signature signature, int count, List<SbdbCadData>? data)
        two00,
    required TResult Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)
        four00,
  }) {
    return two00(signature, count, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult? Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)?
        four00,
  }) {
    return two00?.call(signature, count, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult Function(String message, @JsonKey(name: 'moreInfo') String moreInfo,
            String code)?
        four00,
    required TResult orElse(),
  }) {
    if (two00 != null) {
      return two00(signature, count, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Body value) two00,
    required TResult Function(SbdbCad400Body value) four00,
  }) {
    return two00(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Body value)? two00,
    TResult? Function(SbdbCad400Body value)? four00,
  }) {
    return two00?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Body value)? two00,
    TResult Function(SbdbCad400Body value)? four00,
    required TResult orElse(),
  }) {
    if (two00 != null) {
      return two00(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad200BodyToJson(
      this,
    );
  }
}

abstract class SbdbCad200Body implements SbdbCadBody {
  factory SbdbCad200Body(
      {required final Signature signature,
      required final int count,
      required final List<SbdbCadData>? data}) = _$SbdbCad200Body;

  factory SbdbCad200Body.fromJson(Map<String, dynamic> json) =
      _$SbdbCad200Body.fromJson;

  Signature get signature;
  int get count;
  List<SbdbCadData>? get data;
  @JsonKey(ignore: true)
  _$$SbdbCad200BodyCopyWith<_$SbdbCad200Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SbdbCad400BodyCopyWith<$Res> {
  factory _$$SbdbCad400BodyCopyWith(
          _$SbdbCad400Body value, $Res Function(_$SbdbCad400Body) then) =
      __$$SbdbCad400BodyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String message,
      @JsonKey(name: 'moreInfo') String moreInfo,
      String code});
}

/// @nodoc
class __$$SbdbCad400BodyCopyWithImpl<$Res>
    extends _$SbdbCadBodyCopyWithImpl<$Res, _$SbdbCad400Body>
    implements _$$SbdbCad400BodyCopyWith<$Res> {
  __$$SbdbCad400BodyCopyWithImpl(
      _$SbdbCad400Body _value, $Res Function(_$SbdbCad400Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? moreInfo = null,
    Object? code = null,
  }) {
    return _then(_$SbdbCad400Body(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      moreInfo: null == moreInfo
          ? _value.moreInfo
          : moreInfo // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SbdbCad400Body implements SbdbCad400Body {
  _$SbdbCad400Body(
      {required this.message,
      @JsonKey(name: 'moreInfo') required this.moreInfo,
      required this.code,
      final String? $type})
      : $type = $type ?? 'four00';

  factory _$SbdbCad400Body.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad400BodyFromJson(json);

  @override
  final String message;
  @override
  @JsonKey(name: 'moreInfo')
  final String moreInfo;
  @override
  final String code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SbdbCadBody.four00(message: $message, moreInfo: $moreInfo, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad400Body &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.moreInfo, moreInfo) ||
                other.moreInfo == moreInfo) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, moreInfo, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SbdbCad400BodyCopyWith<_$SbdbCad400Body> get copyWith =>
      __$$SbdbCad400BodyCopyWithImpl<_$SbdbCad400Body>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Signature signature, int count, List<SbdbCadData>? data)
        two00,
    required TResult Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)
        four00,
  }) {
    return four00(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult? Function(String message,
            @JsonKey(name: 'moreInfo') String moreInfo, String code)?
        four00,
  }) {
    return four00?.call(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count, List<SbdbCadData>? data)?
        two00,
    TResult Function(String message, @JsonKey(name: 'moreInfo') String moreInfo,
            String code)?
        four00,
    required TResult orElse(),
  }) {
    if (four00 != null) {
      return four00(message, moreInfo, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Body value) two00,
    required TResult Function(SbdbCad400Body value) four00,
  }) {
    return four00(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Body value)? two00,
    TResult? Function(SbdbCad400Body value)? four00,
  }) {
    return four00?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Body value)? two00,
    TResult Function(SbdbCad400Body value)? four00,
    required TResult orElse(),
  }) {
    if (four00 != null) {
      return four00(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad400BodyToJson(
      this,
    );
  }
}

abstract class SbdbCad400Body implements SbdbCadBody {
  factory SbdbCad400Body(
      {required final String message,
      @JsonKey(name: 'moreInfo') required final String moreInfo,
      required final String code}) = _$SbdbCad400Body;

  factory SbdbCad400Body.fromJson(Map<String, dynamic> json) =
      _$SbdbCad400Body.fromJson;

  String get message;
  @JsonKey(name: 'moreInfo')
  String get moreInfo;
  String get code;
  @JsonKey(ignore: true)
  _$$SbdbCad400BodyCopyWith<_$SbdbCad400Body> get copyWith =>
      throw _privateConstructorUsedError;
}
