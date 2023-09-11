import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/app_back_button_dispatcher.dart';
import 'globals.dart';
import 'route/home/home_route.dart';
import 'route/settings/bloc/settings_bloc.dart';
import 'route/settings/bloc/settings_state.dart';
import 'route/settings/language.dart';

class SpaceDataExplorerApp extends StatelessWidget {
  SpaceDataExplorerApp({
    super.key,
    GlobalKey<NavigatorState>? navigatorKey,
    String? initialLocation,
    bool debugShowCheckedModeBanner = true,
  }) : _debugShowCheckedModeBanner = debugShowCheckedModeBanner {
    _goRouter = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: initialLocation,
      routes: [
        $homeRoute,
      ],
      observers: [SentryNavigatorObserver()],
    );
  }

  late final GoRouter _goRouter;
  final bool _debugShowCheckedModeBanner;
  final _logger = Logger('$appNamePascalCase.App');

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
      supportedLocales: getSupportedLocales(),
      debugShowCheckedModeBanner: _debugShowCheckedModeBanner,
    );
  }

  Locale? localeListResolutionCallback({
    required BuildContext context,
    List<Locale>? locales,
    required Iterable<Locale> supportedLocales,
  }) {
    _logger.fine('localeListResolutionCallback -> $locales');
    final settingsBloc = context.read<SettingsBloc>();
    settingsBloc.add(SettingsSystemLocalesChanged(systemLocales: locales));
    return null;
  }

  List<Locale> getSupportedLocales() {
    return [
      Locale(Language.english.code),
      Locale(Language.hindi.code),
      Locale(Language.marathi.code),
      // Below locales are included for formatting differences like date
      // See test/unit_test/route/settings/date_format_test.dart
      Locale(Language.english.code, 'AU'),
      Locale(Language.english.code, 'CA'),
      Locale(Language.english.code, 'GB'),
      Locale(Language.english.code, 'IE'),
      Locale(Language.english.code, 'IN'),
      Locale(Language.english.code, 'MY'),
      Locale(Language.english.code, 'NZ'),
      Locale(Language.english.code, 'SG'),
      Locale(Language.english.code, 'US'),
      Locale(Language.english.code, 'ZA'),
    ];
  }
}
