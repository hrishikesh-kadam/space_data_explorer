import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../language/language.dart';
import '../../widgets/app_bar.dart';
import 'settings_route.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final settingsTiles = getSettingsTiles(context: context);

    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: const Text(SettingsRoute.displayName),
        actions: null,
      ),
      body: ListView.separated(
        itemCount: settingsTiles.length,
        itemBuilder: (BuildContext context, int index) {
          return settingsTiles[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
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
    return ListTile(
      title: Text(l10n.language),
      subtitle: Text(getLanguageDisplayName(context: context)),
    );
  }

  String getLanguageDisplayName({
    required BuildContext context,
  }) {
    final Locale locale = Localizations.localeOf(context);
    final Language language = Language.fromCode(locale.languageCode);
    return language.displayName;
  }
}
