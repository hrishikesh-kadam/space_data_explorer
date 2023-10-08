import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

part 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> with WidgetsBindingObserver {
  AppBloc() : super(const AppState()) {
    on<AppEvent>((event, emit) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(this.state.copyWith(appLifecycleState: state));
  }
}
