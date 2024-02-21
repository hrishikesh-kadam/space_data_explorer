// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cad_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CadResultState {
  SbdbCadBody get sbdbCadBody => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CadResultStateCopyWith<CadResultState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CadResultStateCopyWith<$Res> {
  factory $CadResultStateCopyWith(
          CadResultState value, $Res Function(CadResultState) then) =
      _$CadResultStateCopyWithImpl<$Res, CadResultState>;
  @useResult
  $Res call({SbdbCadBody sbdbCadBody});

  $SbdbCadBodyCopyWith<$Res> get sbdbCadBody;
}

/// @nodoc
class _$CadResultStateCopyWithImpl<$Res, $Val extends CadResultState>
    implements $CadResultStateCopyWith<$Res> {
  _$CadResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sbdbCadBody = null,
  }) {
    return _then(_value.copyWith(
      sbdbCadBody: null == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SbdbCadBodyCopyWith<$Res> get sbdbCadBody {
    return $SbdbCadBodyCopyWith<$Res>(_value.sbdbCadBody, (value) {
      return _then(_value.copyWith(sbdbCadBody: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CadResultStateImplCopyWith<$Res>
    implements $CadResultStateCopyWith<$Res> {
  factory _$$CadResultStateImplCopyWith(_$CadResultStateImpl value,
          $Res Function(_$CadResultStateImpl) then) =
      __$$CadResultStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SbdbCadBody sbdbCadBody});

  @override
  $SbdbCadBodyCopyWith<$Res> get sbdbCadBody;
}

/// @nodoc
class __$$CadResultStateImplCopyWithImpl<$Res>
    extends _$CadResultStateCopyWithImpl<$Res, _$CadResultStateImpl>
    implements _$$CadResultStateImplCopyWith<$Res> {
  __$$CadResultStateImplCopyWithImpl(
      _$CadResultStateImpl _value, $Res Function(_$CadResultStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sbdbCadBody = null,
  }) {
    return _then(_$CadResultStateImpl(
      sbdbCadBody: null == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody,
    ));
  }
}

/// @nodoc

class _$CadResultStateImpl implements _CadResultState {
  _$CadResultStateImpl({required this.sbdbCadBody});

  @override
  final SbdbCadBody sbdbCadBody;

  @override
  String toString() {
    return 'CadResultState(sbdbCadBody: $sbdbCadBody)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CadResultStateImpl &&
            (identical(other.sbdbCadBody, sbdbCadBody) ||
                other.sbdbCadBody == sbdbCadBody));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sbdbCadBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CadResultStateImplCopyWith<_$CadResultStateImpl> get copyWith =>
      __$$CadResultStateImplCopyWithImpl<_$CadResultStateImpl>(
          this, _$identity);
}

abstract class _CadResultState implements CadResultState {
  factory _CadResultState({required final SbdbCadBody sbdbCadBody}) =
      _$CadResultStateImpl;

  @override
  SbdbCadBody get sbdbCadBody;
  @override
  @JsonKey(ignore: true)
  _$$CadResultStateImplCopyWith<_$CadResultStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
