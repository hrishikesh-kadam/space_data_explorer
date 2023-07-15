import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

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
    return BlocProvider(
      lazy: false,
      create: (_) => createSettingsBloc(context: context),
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: const Text(SettingsRoute.displayName),
        ),
        body: Builder(builder: (context) {
          final settingsTiles = getSettingsTiles(context: context);
          return ListView.separated(
            itemCount: settingsTiles.length,
            itemBuilder: (context, index) {
              return settingsTiles[index];
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }),
      ),
    );
  }

  SettingsBloc createSettingsBloc({
    required BuildContext context,
  }) {
    final locale = Localizations.localeOf(context);
    final currentLanguage = Language.fromCode(locale.languageCode);
    final dateFormat = DateFormat.yMd(locale.toString());
    return SettingsBloc(
      language: currentLanguage,
      dateFormat: dateFormat,
    );
  }

  List<Widget> getSettingsTiles({
    required BuildContext context,
  }) {
    return [
      getLanguageTile(context: context),
    ];
  }

  Widget getLanguageTile({
    required BuildContext context,
  }) {
    const values = <Language>[
      Language.english,
      Language.hindi,
      Language.marathi,
    ];
    final List<String> valueTitles =
        values.map((e) => e.displayName).toList(growable: false);

    return BlocSelector<SettingsBloc, SettingsState, Language>(
      selector: (state) => state.language,
      builder: (context, language) {
        return RadioSettingsTile<Language>(
          title: l10n.language,
          subTitle: language.displayName,
          values: values,
          valueTitles: valueTitles,
          groupValue: language,
          onChanged: (selectedLanguage) {
            if (selectedLanguage != null) {
              _log.debug('selectedLanguage -> $selectedLanguage');
              final settingsBloc = context.read<SettingsBloc>();
              settingsBloc.add(SettingsLaguageSelected(
                language: selectedLanguage,
              ));
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
