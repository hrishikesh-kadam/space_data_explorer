import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/directionality_widget.dart';
import '../../widgets/radio_settings_tile.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'date_format_pattern.dart';
import 'locale.dart';
import 'settings_route.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;
  final _logger = Logger('$appNamePascalCase.SettingsScreen');
  static const String keyPrefix = 'settings_screen';
  static const Key localeTileKey = Key('${keyPrefix}_locale_tile');
  static const Key localeDialogKey = Key('${keyPrefix}_locale_dialog');
  static const Key dateFormatTileKey = Key('${keyPrefix}_date_format_tile');
  static const Key dateFormatDialogKey = Key('${keyPrefix}_date_format_dialog');
  static const Key textDirectionTileKey =
      Key('${keyPrefix}_text_direction_tile');
  static const Key textDirectionDialogKey =
      Key('${keyPrefix}_text_direction_dialog');

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) =>
          previous.systemLocales != current.systemLocales,
      listener: (context, state) {
        final isAnyDialogOpen = state.isAnyDialogShown;
        _logger.fine(
            'systemLocales listener -> isAnyDialogOpen = $isAnyDialogOpen');
        if (isAnyDialogOpen != null && isAnyDialogOpen) {
          Navigator.pop(context);
        }
      },
      child: getDirectionality(
        child: Scaffold(
          appBar: getAppBar(
            context: context,
            title: const Text(SettingsRoute.displayName),
          ),
          body: _getBody(),
        ),
      ),
    );
  }

  Builder _getBody() {
    return Builder(
      builder: (context) {
        final settingsTiles = _getSettingsTiles();
        return ListView.separated(
          itemCount: settingsTiles.length,
          itemBuilder: (context, index) {
            return settingsTiles[index];
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }

  List<Widget> _getSettingsTiles() {
    return [
      _getLocaleTile(),
      _getDateFormatTile(),
      _getTextDirectionTile(),
    ];
  }

  static String getLocaleValueTitle({
    required AppLocalizations l10n,
    required Locale? locale,
  }) {
    return switch (locale) {
      null => l10n.system,
      _ => locale.toDisplayName(),
    };
  }

  Widget _getLocaleTile() {
    final Set<Locale?> values = {null, ...LocaleExt.getSupportedLocales()};
    final Set<String> valueTitles =
        values.map((e) => getLocaleValueTitle(l10n: l10n, locale: e)).toSet();
    return BlocSelector<SettingsBloc, SettingsState, Locale?>(
      selector: (state) => state.locale,
      builder: (context, locale) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<Locale?>(
          key: localeTileKey,
          dialogKey: localeDialogKey,
          title: l10n.language,
          subTitle: getLocaleValueTitle(l10n: l10n, locale: locale),
          values: values,
          valueTitles: valueTitles,
          groupValue: locale,
          onChanged: (selectedLocale) {
            _logger.fine('selectedLocale -> $selectedLocale');
            settingsBloc.add(SettingsLocaleSelected(
              locale: selectedLocale,
            ));
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('_getLocaleTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('_getLocaleTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }

  static String getDateFormatValueTitle({
    required AppLocalizations l10n,
    required DateFormatPattern dateFormatPattern,
  }) {
    return switch (dateFormatPattern) {
      DateFormatPattern.yMd => l10n.languageDefault,
      _ => dateFormatPattern.pattern,
    };
  }

  Widget _getDateFormatTile() {
    final Set<DateFormatPattern> values = DateFormatPattern.values.toSet();
    final Set<String> valueTitles = values
        .map((e) => getDateFormatValueTitle(l10n: l10n, dateFormatPattern: e))
        .toSet();
    return BlocSelector<SettingsBloc, SettingsState, DateFormatPattern>(
      selector: (state) => state.dateFormatPattern,
      builder: (context, dateFormatPattern) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<DateFormatPattern>(
          key: dateFormatTileKey,
          dialogKey: dateFormatDialogKey,
          title: l10n.dateFormat,
          subTitle: getDateFormatValueTitle(
              l10n: l10n, dateFormatPattern: dateFormatPattern),
          values: values,
          valueTitles: valueTitles,
          groupValue: dateFormatPattern,
          onChanged: (selectedDateFormatPattern) {
            if (selectedDateFormatPattern != null) {
              _logger.fine(
                  'getDateFormatTile() -> selectedDateFormatPattern -> $selectedDateFormatPattern');
              settingsBloc.add(SettingsDateFormatSelected(
                dateFormatPattern: selectedDateFormatPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('getDateFormatTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('getDateFormatTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }

  static String getTextDirectionValueTitle({
    required AppLocalizations l10n,
    required TextDirection? textDirection,
  }) {
    return switch (textDirection) {
      null => l10n.system,
      TextDirection.ltr => l10n.leftToRight,
      TextDirection.rtl => l10n.rightToLeft,
    };
  }

  Widget _getTextDirectionTile() {
    final Set<TextDirection?> values = {
      null,
      TextDirection.ltr,
      TextDirection.rtl,
    };
    final Set<String> valueTitles = values
        .map((e) => getTextDirectionValueTitle(l10n: l10n, textDirection: e))
        .toSet();
    return BlocSelector<SettingsBloc, SettingsState, TextDirection?>(
      selector: (state) => state.textDirection,
      builder: (context, textDirection) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<TextDirection?>(
          key: textDirectionTileKey,
          dialogKey: textDirectionDialogKey,
          title: l10n.textDirection,
          subTitle: getTextDirectionValueTitle(
            l10n: l10n,
            textDirection: textDirection,
          ),
          values: values,
          valueTitles: valueTitles,
          groupValue: textDirection,
          onChanged: (selectedTextDirection) {
            _logger.fine('selectedTextDirection -> $selectedTextDirection');
            settingsBloc.add(SettingsTextDirectionSelected(
              textDirection: selectedTextDirection,
            ));
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('getTextDirectionTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('getTextDirectionTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }
}
