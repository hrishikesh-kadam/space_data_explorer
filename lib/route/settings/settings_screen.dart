import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../globals.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/directionality_widget.dart';
import '../../widgets/radio_settings_tile.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'date_format_pattern.dart';
import 'locale.dart';
import 'settings_route.dart';
import 'time_format_pattern.dart';

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
  static const Key timeFormatTileKey = Key('${keyPrefix}_time_format_tile');
  static const Key timeFormatDialogKey = Key('${keyPrefix}_time_format_dialog');
  static const Key textDirectionTileKey =
      Key('${keyPrefix}_text_direction_tile');
  static const Key textDirectionDialogKey =
      Key('${keyPrefix}_text_direction_dialog');
  static const Key distanceUnitTileKey = Key('${keyPrefix}_distance_unit_tile');
  static const Key distanceUnitDialogKey =
      Key('${keyPrefix}_distance_unit_dialog');
  static const Key velocityUnitTileKey = Key('${keyPrefix}_velocity_unit_tile');
  static const Key velocityUnitDialogKey =
      Key('${keyPrefix}_velocity_unit_dialog');

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
      _getTimeFormatTile(),
      _getTextDirectionTile(),
      _getDistanceUnitTile(),
      _getVelocityUnitTile(),
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
            l10n: l10n,
            dateFormatPattern: dateFormatPattern,
          ),
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

  static String getTimeFormatValueTitle({
    required AppLocalizations l10n,
    required TimeFormatPattern timeFormatPattern,
  }) {
    return switch (timeFormatPattern) {
      TimeFormatPattern.jm => l10n.languageDefault,
      TimeFormatPattern.twelveHourClock => l10n.twelveHourClock,
      TimeFormatPattern.twentyFourHourClock => l10n.twentyFourHourClock,
    };
  }

  Widget _getTimeFormatTile() {
    final Set<TimeFormatPattern> values = TimeFormatPattern.values.toSet();
    final Set<String> valueTitles = values
        .map((e) => getTimeFormatValueTitle(l10n: l10n, timeFormatPattern: e))
        .toSet();
    return BlocSelector<SettingsBloc, SettingsState, TimeFormatPattern>(
      selector: (state) => state.timeFormatPattern,
      builder: (context, timeFormatPattern) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<TimeFormatPattern>(
          key: timeFormatTileKey,
          dialogKey: timeFormatDialogKey,
          title: l10n.timeFormat,
          subTitle: getTimeFormatValueTitle(
            l10n: l10n,
            timeFormatPattern: timeFormatPattern,
          ),
          values: values,
          valueTitles: valueTitles,
          groupValue: timeFormatPattern,
          onChanged: (selectedTimeFormatPattern) {
            if (selectedTimeFormatPattern != null) {
              _logger.fine(
                  '_getTimeFormatTile() -> selectedTimeFormatPattern -> $selectedTimeFormatPattern');
              settingsBloc.add(SettingsTimeFormatSelected(
                timeFormatPattern: selectedTimeFormatPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('_getTimeFormatTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('_getTimeFormatTile() -> afterShowDialog');
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

  static String getDistanceUnitValueTitle({
    required AppLocalizations l10n,
    required DistanceUnit distanceUnit,
  }) {
    return switch (distanceUnit) {
      DistanceUnit.au =>
        '${l10n.auDistanceUnitLabel} (${l10n.auDistanceUnitSymbol})',
      DistanceUnit.LD =>
        '${l10n.lunarDistanceUnitLabel} (${l10n.lunarDistanceUnitSymbol})',
      DistanceUnit.km =>
        '${l10n.kmDistanceUnitLabel} (${l10n.kmDistanceUnitSymbol})',
      DistanceUnit.mi =>
        '${l10n.miDistanceUnitLabel} (${l10n.miDistanceUnitSymbol})',
      DistanceUnit.Re =>
        '${l10n.reDistanceUnitLabel} (${l10n.reDistanceUnitSymbol})',
      _ => throw ArgumentError.value(distanceUnit),
    };
  }

  Widget _getDistanceUnitTile() {
    final Set<DistanceUnit> values = DistanceUnit.all.toSet();
    final Set<String> valueTitles = values
        .map((e) => getDistanceUnitValueTitle(l10n: l10n, distanceUnit: e))
        .toSet();
    return BlocSelector<SettingsBloc, SettingsState, DistanceUnit>(
      selector: (state) => state.distanceUnit,
      builder: (context, distanceUnit) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<DistanceUnit>(
          key: distanceUnitTileKey,
          dialogKey: distanceUnitDialogKey,
          title: l10n.distanceUnit,
          subTitle: getDistanceUnitValueTitle(
            l10n: l10n,
            distanceUnit: distanceUnit,
          ),
          values: values,
          valueTitles: valueTitles,
          groupValue: distanceUnit,
          onChanged: (selectedDistanceUnitPattern) {
            if (selectedDistanceUnitPattern != null) {
              _logger.fine(
                  '_getDistanceUnitTile() -> selectedDistanceUnitPattern -> $selectedDistanceUnitPattern');
              settingsBloc.add(SettingsDistanceUnitSelected(
                distanceUnit: selectedDistanceUnitPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('_getDistanceUnitTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('_getDistanceUnitTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }

  static String getVelocityUnitValueTitle({
    required AppLocalizations l10n,
    required VelocityUnit velocityUnit,
  }) {
    return switch (velocityUnit) {
      VelocityUnit.kmps =>
        '${l10n.kmpsVelocityUnitLabel} (${l10n.kmpsVelocityUnitSymbol})',
      VelocityUnit.miph =>
        '${l10n.miphVelocityUnitLabel} (${l10n.miphVelocityUnitSymbol})',
      VelocityUnit.aupd =>
        '${l10n.aupdVelocityUnitLabel} (${l10n.aupdVelocityUnitSymbol})',
      _ => throw ArgumentError.value(velocityUnit),
    };
  }

  Widget _getVelocityUnitTile() {
    final Set<VelocityUnit> values = VelocityUnit.all.toSet();
    final Set<String> valueTitles = values
        .map((e) => getVelocityUnitValueTitle(l10n: l10n, velocityUnit: e))
        .toSet();
    return BlocSelector<SettingsBloc, SettingsState, VelocityUnit>(
      selector: (state) => state.velocityUnit,
      builder: (context, velocityUnit) {
        final settingsBloc = context.read<SettingsBloc>();
        return RadioSettingsTile<VelocityUnit>(
          key: velocityUnitTileKey,
          dialogKey: velocityUnitDialogKey,
          title: l10n.velocityUnit,
          subTitle: getVelocityUnitValueTitle(
            l10n: l10n,
            velocityUnit: velocityUnit,
          ),
          values: values,
          valueTitles: valueTitles,
          groupValue: velocityUnit,
          onChanged: (selectedVelocityUnitPattern) {
            if (selectedVelocityUnitPattern != null) {
              _logger.fine(
                  '_getVelocityUnitTile() -> selectedVelocityUnitPattern -> $selectedVelocityUnitPattern');
              settingsBloc.add(SettingsVelocityUnitSelected(
                velocityUnit: selectedVelocityUnitPattern,
              ));
            }
            Navigator.pop(context);
          },
          beforeShowDialog: () {
            _logger.finer('_getVelocityUnitTile() -> beforeShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: true,
            ));
          },
          afterShowDialog: () {
            _logger.finer('_getVelocityUnitTile() -> afterShowDialog');
            settingsBloc.add(const SettingsDialogEvent(
              isAnyDialogShown: false,
            ));
          },
        );
      },
    );
  }
}
