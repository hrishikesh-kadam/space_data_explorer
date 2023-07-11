part of 'cad_bloc.dart';

@immutable
sealed class CadEvent extends Equatable {
  const CadEvent();

  @override
  List<Object> get props => [];
}

class CadRequested extends CadEvent {
  const CadRequested({
    this.queryParameters,
  });

  final JsonMap? queryParameters;
}

class CadDateRangeSelected extends CadEvent {
  const CadDateRangeSelected({
    this.dateRange,
  });

  final DateTimeRange? dateRange;
}
