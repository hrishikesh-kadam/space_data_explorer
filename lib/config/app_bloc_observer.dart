import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../extension/logger.dart';
import '../globals.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @visibleForTesting
  static final Logger logger = Logger('$appNamePascalCase.AppBlocObserver')
    ..level = Level.ALL;

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.reportError(
      '${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
      information: [bloc],
    );
    super.onError(bloc, error, stackTrace);
  }
}
