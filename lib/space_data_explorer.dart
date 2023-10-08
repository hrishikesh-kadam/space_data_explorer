import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'bloc/app_bloc.dart';
import 'config/app_back_button_dispatcher.dart';
import 'extension/go_router.dart';
import 'globals.dart';
import 'route/home/home_route.dart';
import 'route/page_not_found/page_not_found_route.dart';
import 'route/settings/bloc/settings_bloc.dart';
import 'route/settings/bloc/settings_state.dart';
import 'route/settings/locale.dart';

class SpaceDataExplorerApp extends StatefulWidget {
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
        $pageNotFoundRoute,
      ],
      onException: GoRouterExt.onException,
      observers: [SentryNavigatorObserver()],
    );
  }

  late final GoRouter _goRouter;
  final bool _debugShowCheckedModeBanner;

  @override
  State<SpaceDataExplorerApp> createState() => _SpaceDataExplorerAppState();
}

class _SpaceDataExplorerAppState extends State<SpaceDataExplorerApp> {
  final _logger = Logger('$appNamePascalCase.App');
  late final AppBloc appBloc;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    WidgetsBinding.instance.addObserver(appBloc);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(appBloc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (_) => appBloc),
        BlocProvider<SettingsBloc>(create: (_) => SettingsBloc()),
      ],
      child: BlocSelector<SettingsBloc, SettingsState, Locale?>(
        selector: (state) => state.locale,
        builder: (context, locale) {
          return getApp(
            context: context,
            locale: locale,
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
      routeInformationProvider: widget._goRouter.routeInformationProvider,
      routeInformationParser: widget._goRouter.routeInformationParser,
      routerDelegate: widget._goRouter.routerDelegate,
      backButtonDispatcher: AppBackButtonDispatcher(goRouter: widget._goRouter),
      // onGenerateTitle: (context) {
      //   return AppLocalizations.of(context).spaceDataExplorer;
      // },
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
      supportedLocales: LocaleExt.getSupportedLocales(),
      debugShowCheckedModeBanner: widget._debugShowCheckedModeBanner,
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
}
