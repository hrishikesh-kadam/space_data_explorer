import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../constants/constants.dart';
import '../../language/language.dart';
import '../../widgets/app_bar.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'radio_settings_tile.dart';
import 'settings_route.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;
  final _log = Logger('$appNamePascalCase.SettingsScreen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(SettingsRoute.displayName),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final isAnyDialogOpen = state.isAnyDialogShown;
          if (isAnyDialogOpen != null && isAnyDialogOpen) {
            Navigator.pop(context);
          }
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
    );
  }

  List<Widget> getSettingsTiles() {
    return [
      getLanguageTile(),
      getDateFormatTile(),
    ];
  }

  Widget getLanguageTile() {
    const values = <Language>[
      Language.system,
      Language.english,
      Language.hindi,
      Language.marathi,
    ];
    List<String> valueTitles = [
      l10n.system,
      ...values.sublist(1).map((e) => e.displayName!).toList(),
    ];

    return BlocSelector<SettingsBloc, SettingsState, Language>(
      selector: (state) => state.language,
      builder: (context, language) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<Language>(
          title: l10n.language,
          subTitle:
              language == Language.system ? l10n.system : language.displayName,
          values: values,
          valueTitles: valueTitles,
          groupValue: language,
          onChanged: (selectedLanguage) {
            if (selectedLanguage != null) {
              _log.debug('selectedLanguage -> $selectedLanguage');
              settingsBloc.add(SettingsLaguageSelected(
                language: selectedLanguage,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            onEventShowDialog(
              settingsBloc: settingsBloc,
              isAnyDialogShown: true,
              tileTrace: 'getLanguageTile',
            );
          },
          afterShowDialog: () {
            onEventShowDialog(
              settingsBloc: settingsBloc,
              isAnyDialogShown: false,
              tileTrace: 'getLanguageTile',
            );
          },
        );
      },
    );
  }

  Widget getDateFormatTile() {
    final values = <String>[
      SettingsBloc.dateSkeleton,
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'yyyy/MM/dd',
    ];
    List<String> valueTitles = [
      l10n.system,
      ...values.sublist(1),
    ];

    return BlocSelector<SettingsBloc, SettingsState, String>(
      selector: (state) => state.dateFormatPattern,
      builder: (context, dateFormatPattern) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<String>(
          title: l10n.dateFormat,
          subTitle: dateFormatPattern == SettingsBloc.dateSkeleton
              ? l10n.system
              : dateFormatPattern,
          values: values,
          valueTitles: valueTitles,
          groupValue: dateFormatPattern,
          onChanged: (selectedDateFormatPattern) {
            if (selectedDateFormatPattern != null) {
              _log.debug(
                  'getDateFormatTile -> selectedDateFormatPattern -> $selectedDateFormatPattern');
              settingsBloc.add(SettingsDateFormatSelected(
                dateFormatPattern: selectedDateFormatPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            onEventShowDialog(
              settingsBloc: settingsBloc,
              isAnyDialogShown: true,
              tileTrace: 'getDateFormatTile',
            );
          },
          afterShowDialog: () {
            onEventShowDialog(
              settingsBloc: settingsBloc,
              isAnyDialogShown: false,
              tileTrace: 'getDateFormatTile',
            );
          },
        );
      },
    );
  }

  void onEventShowDialog({
    required SettingsBloc settingsBloc,
    bool? isAnyDialogShown,
    String? tileTrace,
  }) {
    if (isAnyDialogShown == true) {
      _log.debug('$tileTrace -> before showDialog');
    } else if (isAnyDialogShown == false) {
      _log.debug('$tileTrace -> after showDialog');
    }
    settingsBloc.add(SettingsDialogEvent(
      isAnyDialogShown: isAnyDialogShown,
    ));
  }
}
