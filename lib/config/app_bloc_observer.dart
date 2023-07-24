import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../constants/constants.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @visibleForTesting
  static final Logger log = Logger('$appNamePascalCase.AppBlocObserver')
    ..level = Level.ALL;

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.error('${bloc.runtimeType}');
    log.error('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
