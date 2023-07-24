import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:space_data_explorer/config/app_bloc_observer.dart';
import 'package:space_data_explorer/config/config.dart';

void main() {
  group('$AppBlocObserver Unit Test', () {
    _CounterBloc counterBloc;

    setUpAll(() {
      configureHrkLogging();
      configureBloc();
      AppBlocObserver.log.level = Level.OFF;
    });

    test('onError', () {
      counterBloc = _CounterBloc();
      counterBloc.add(_CounterTestOnError());
    });
  });
}

sealed class _CounterEvent {}

final class _CounterTestOnError extends _CounterEvent {}

class _CounterBloc extends Bloc<_CounterEvent, int> {
  _CounterBloc() : super(0) {
    on<_CounterTestOnError>((event, emit) {
      addError(Exception('Testing CounterTestOnError!'), StackTrace.current);
    });
  }
}
