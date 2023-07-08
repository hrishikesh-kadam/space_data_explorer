part of 'cad_bloc.dart';

@immutable
sealed class CadState extends Equatable {
  const CadState();

  @override
  List<Object> get props => [];
}

class CadInitial extends CadState {}

class CadRequestSent extends CadState {}

class CadRequestSuccess extends CadState {
  const CadRequestSuccess({required this.sbdbCadBody});

  final SbdbCadBody sbdbCadBody;

  @override
  List<Object> get props => [sbdbCadBody];
}

class CadRequestFailure extends CadState {}
