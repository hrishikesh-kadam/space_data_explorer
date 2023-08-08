import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../constants/constants.dart';
import 'cad_state.dart';

part 'cad_event.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc({
    SbdbCadApi? sbdbCadApi,
  }) : super(CadState()) {
    this.sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
    on<CadSmallBodySelected>(_onCadSmallBodySelected);
    on<CadSmallBodySelectorEvent>(_onCadSmallBodySelectorEvent);
    on<CadCloseApproachBodySelected>(_onCadCloseApproachBodySelected);
    on<CadTotalOnlySelected>(_onCadTotalOnlySelected);
    on<CadDiameterSelected>(_onCadDiameterSelected);
    on<CadFullnameSelected>(_onCadFullnameSelected);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  @visibleForTesting
  late final SbdbCadApi sbdbCadApi;

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(networkState: NetworkState.sending));
    try {
      SbdbCadQueryParameters queryParameters = SbdbCadQueryParameters();
      if (state.dateRange != null) {
        queryParameters = queryParameters.copyWith(
          dateMin: dateFormatter.format(state.dateRange!.start),
          dateMax: dateFormatter.format(state.dateRange!.end),
        );
      }
      queryParameters = queryParameters.copyWithSmallBody(state.smallBody);
      switch (state.smallBodySelector) {
        case SmallBodySelector.spkId:
          queryParameters = queryParameters.copyWith(spk: state.spkId);
        case SmallBodySelector.designation:
          queryParameters = queryParameters.copyWith(des: state.designation);
        default:
      }
      if (state.closeApproachBody !=
          SbdbCadQueryParameters.defaultCloseApproachBody) {
        queryParameters = queryParameters.copyWith(
          body: state.closeApproachBody,
        );
      }
      if (state.totalOnly == true) {
        queryParameters = queryParameters.copyWith(totalOnly: true);
      }
      if (state.diameter == true) {
        queryParameters = queryParameters.copyWith(diameter: true);
      }
      if (state.fullname == true) {
        queryParameters = queryParameters.copyWith(fullname: true);
      }
      Response<SbdbCadBody> response = await sbdbCadApi.get(
        queryParameters: queryParameters.toJson(),
      );
      _log.fine('_onCadRequested success');
      emit(state.copyWith(
        networkState: NetworkState.success,
        sbdbCadBody: response.data,
      ));
    } on Exception catch (e, s) {
      _log.error('_onCadRequested failure', e, s);
      emit(state.copyWith(networkState: NetworkState.failure));
    }
  }

  Future<void> _onCadDateRangeSelected(
    CadDateRangeSelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(dateRange: event.dateRange));
  }

  Future<void> _onCadSmallBodySelected(
    CadSmallBodySelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.smallBody == null) {
      emit(state.copyWith(smallBody: SbdbCadQueryParameters.defaultSmallBody));
    } else {
      emit(state.copyWith(smallBody: event.smallBody!));
    }
  }

  Future<void> _onCadSmallBodySelectorEvent(
    CadSmallBodySelectorEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      smallBodySelector: event.smallBodySelector,
      spkId: event.spkId,
      designation: event.designation,
    ));
  }

  Future<void> _onCadCloseApproachBodySelected(
    CadCloseApproachBodySelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.closeApproachBody == null) {
      emit(state.copyWith(
        closeApproachBody: SbdbCadQueryParameters.defaultCloseApproachBody,
      ));
    } else {
      emit(state.copyWith(closeApproachBody: event.closeApproachBody!));
    }
  }

  Future<void> _onCadTotalOnlySelected(
    CadTotalOnlySelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      totalOnly: event.selected == true ? true : null,
    ));
  }

  Future<void> _onCadDiameterSelected(
    CadDiameterSelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      diameter: event.selected == true ? true : null,
    ));
  }

  Future<void> _onCadFullnameSelected(
    CadFullnameSelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      fullname: event.selected == true ? true : null,
    ));
  }
}
