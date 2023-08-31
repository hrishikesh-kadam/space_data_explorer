import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/radio_settings_tile.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'date_format_pattern.dart';
import 'language.dart';
import 'settings_route.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;
  final _logger = Logger('$appNamePascalCase.SettingsScreen');
  static const Key languageTileKey = Key('settings_screen_language_tile');
  static const Key languageDialogKey = Key('settings_screen_language_dialog');
  static const Key dateFormatTileKey = Key('settings_screen_date_format_tile');
  static const Key dateFormatDialogKey =
      Key('settings_screen_date_format_dialog');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(SettingsRoute.displayName),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listenWhen: (previous, current) =>
            previous.systemLocales != current.systemLocales,
        listener: (context, state) {
          final isAnyDialogOpen = state.isAnyDialogShown;
          _logger.debug(
              'systemLocales listener -> isAnyDialogOpen = $isAnyDialogOpen');
          if (isAnyDialogOpen != null && isAnyDialogOpen) {
            Navigator.pop(context);
          }
        },
        child: Builder(
          builder: (context) {
            final settingsTiles = getSettingsTiles();
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
        ),
      ),
    );
  }

  List<Widget> getSettingsTiles() {
    return [
      getLanguageTile(),
      getDateFormatTile(),
    ];
  }

  static String getLanguageValueTitle({
    required AppLocalizations l10n,
    required Language language,
  }) {
    return switch (language) {
      Language.system => l10n.system,
      _ => language.displayName!,
    };
  }

  Widget getLanguageTile() {
    const values = <Language>[
      Language.system,
      Language.english,
      Language.hindi,
      Language.marathi,
    ];
    List<String> valueTitles = values
        .map((e) => getLanguageValueTitle(l10n: l10n, language: e))
        .toList();

    return BlocSelector<SettingsBloc, SettingsState, Language>(
      selector: (state) => state.language,
      builder: (context, language) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<Language>(
          key: languageTileKey,
          dialogKey: languageDialogKey,
          title: l10n.language,
          subTitle: getLanguageValueTitle(l10n: l10n, language: language),
          values: values,
          valueTitles: valueTitles,
          groupValue: language,
          onChanged: (selectedLanguage) {
            if (selectedLanguage != null) {
              _logger.debug('selectedLanguage -> $selectedLanguage');
              settingsBloc.add(SettingsLaguageSelected(
                language: selectedLanguage,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.debug('getLanguageTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.debug('getLanguageTile() -> afterShowDialog');
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

  Widget getDateFormatTile() {
    final values = <DateFormatPattern>[
      DateFormatPattern.yMd,
      DateFormatPattern.ddMMyyyy,
      DateFormatPattern.MMddyyyy,
      DateFormatPattern.yyyyMMdd,
    ];
    List<String> valueTitles = values
        .map((e) => getDateFormatValueTitle(l10n: l10n, dateFormatPattern: e))
        .toList();

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
              _logger.debug(
                  'getDateFormatTile() -> selectedDateFormatPattern -> $selectedDateFormatPattern');
              settingsBloc.add(SettingsDateFormatSelected(
                dateFormatPattern: selectedDateFormatPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.debug('getDateFormatTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.debug('getDateFormatTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }
}
