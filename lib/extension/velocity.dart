import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

extension VelocityUnitExt on VelocityUnit {
  String getLocalizedSymbol(
    AppLocalizations l10n,
  ) {
    return switch (this) {
      VelocityUnit.kmps => l10n.kmpsVelocityUnitSymbol,
      VelocityUnit.miph => l10n.miphVelocityUnitSymbol,
      VelocityUnit.aupd => l10n.aupdVelocityUnitSymbol,
      _ => symbol,
    };
  }
}

extension VelocityExt on Velocity {
  String toLocalizedString(
    AppLocalizations l10n,
  ) {
    return '$value ${unit.getLocalizedSymbol(l10n)}';
  }
}
