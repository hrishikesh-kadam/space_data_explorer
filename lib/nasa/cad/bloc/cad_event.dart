part of 'cad_bloc.dart';

@immutable
sealed class CadEvent {
  const CadEvent();
}

class CadRequested extends CadEvent {
  const CadRequested({this.queryParameters});

  final JsonMap? queryParameters;
}

class CadDateRangeSelected extends CadEvent {
  const CadDateRangeSelected({this.dateRange});

  final DateTimeRange? dateRange;
}
