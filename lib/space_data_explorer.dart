import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'config/app_back_button_dispatcher.dart';
import 'language/language.dart';
import 'route/home/home_route.dart';
import 'route/settings/bloc/settings_bloc.dart';
import 'route/settings/bloc/settings_state.dart';

class SpaceDataExplorerApp extends StatelessWidget {
  SpaceDataExplorerApp({
    super.key,
    GlobalKey<NavigatorState>? navigatorKey,
    String? initialLocation,
    bool debugShowCheckedModeBanner = true,
  })  : _debugShowCheckedModeBanner = debugShowCheckedModeBanner,
        _initialLocation = initialLocation {
    _goRouter = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: _initialLocation,
      routes: [
        $homeRoute,
      ],
    );
  }

  final String? _initialLocation;
  late final GoRouter _goRouter;
  final bool _debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc.getInitialSettings(),
      child: BlocSelector<SettingsBloc, SettingsState, Language>(
        selector: (state) => state.language,
        builder: (context, language) {
          return getApp(
            locale: Locale(language.code),
          );
        },
      ),
    );
  }

  Widget getApp({
    Locale? locale,
  }) {
    return MaterialApp.router(
      routeInformationProvider: _goRouter.routeInformationProvider,
      routeInformationParser: _goRouter.routeInformationParser,
      routerDelegate: _goRouter.routerDelegate,
      backButtonDispatcher: AppBackButtonDispatcher(goRouter: _goRouter),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: <Locale>[
        Locale(Language.english.code),
        Locale(Language.hindi.code),
        Locale(Language.marathi.code),
      ],
      debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
    );
  }
}
