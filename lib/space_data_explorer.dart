import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'config/app_back_button_dispatcher.dart';
import 'constants/constants.dart';
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
  final _log = Logger('$appNamePascalCase.App');

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc.getInitialSettings(),
      child: BlocSelector<SettingsBloc, SettingsState, Language>(
        selector: (state) => state.language,
        builder: (context, language) {
          return getApp(
            context: context,
            locale: language != Language.system ? Locale(language.code) : null,
          );
        },
      ),
    );
  }

  Widget getApp({
    required BuildContext context,
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
      localeListResolutionCallback: (locales, supportedLocales) {
        return localeListResolutionCallback(
          context: context,
          locales: locales,
          supportedLocales: supportedLocales,
        );
      },
      supportedLocales: <Locale>[
        Locale(Language.english.code),
        Locale(Language.hindi.code),
        Locale(Language.marathi.code),
      ],
      debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
    );
  }

  Locale? localeListResolutionCallback({
    required BuildContext context,
    List<Locale>? locales,
    required Iterable<Locale> supportedLocales,
  }) {
    _log.debug('localeListResolutionCallback -> $locales');
    final settingsBloc = context.read<SettingsBloc>();
    settingsBloc.add(SettingsSystemLocalesChanged(systemLocales: locales));
    return null;
  }
}
