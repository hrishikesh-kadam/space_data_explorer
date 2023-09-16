import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

extension DistanceUnitExt on DistanceUnit {
  String getLocalizedSymbol(
    AppLocalizations l10n,
  ) {
    return switch (this) {
      DistanceUnit.au => l10n.auDistanceUnitSymbol,
      DistanceUnit.LD => l10n.lunarDistanceUnitSymbol,
      DistanceUnit.km => l10n.kmDistanceUnitSymbol,
      DistanceUnit.mi => l10n.miDistanceUnitSymbol,
      DistanceUnit.Re => l10n.reDistanceUnitSymbol,
      _ => symbol,
    };
  }
}

extension DistanceExt on Distance {
  String toLocalizedString(
    AppLocalizations l10n,
  ) {
    return '$value ${unit.getLocalizedSymbol(l10n)}';
  }
}
