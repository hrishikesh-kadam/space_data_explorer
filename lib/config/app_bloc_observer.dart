import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../constants/constants.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  static final Logger _log = Logger('$appNamePascalCase.AppBlocObserver')
    ..level = Level.ALL;

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log.error('${bloc.runtimeType}');
    _log.error('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
