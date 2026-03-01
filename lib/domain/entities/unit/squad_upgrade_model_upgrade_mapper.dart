import 'package:gearforce/data/static/mod_functions.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';

String squadUpgradeModelUpgradeId(String squadUpgradeId) {
  return 'squad-model-upgrade-$squadUpgradeId';
}

ModelUpgrade squadUpgradeToModelUpgrade(SquadUpgrade squadUpgrade) {
  final hasReact = squadUpgrade.column == SquadUpgradeColumn.react;
  final weaponSpec = WeaponParser.parseWeaponString(
    squadUpgrade.weaponCode,
    hasReact: hasReact,
  );

  return ModelUpgrade(
    '${squadUpgrade.tv}TV Add ${squadUpgrade.weaponCode}',
    id: squadUpgradeModelUpgradeId(squadUpgrade.id),
    description: squadUpgrade.description,
    tvMod: createIntAdjustmentMod(squadUpgrade.tv),
    weaponsMod: createAddWeaponsMod([weaponSpec]),
  );
}

List<ModelUpgrade> buildSquadProvidedModelUpgrades({
  required Squad squad,
  required Model model,
}) {
  return squad.upgrades
      .where(
        (squadUpgrade) =>
            squadUpgrade.canApplyToClassification(model.base.classification),
      )
      .map(squadUpgradeToModelUpgrade)
      .toList(growable: false);
}

List<ModelUpgrade> mergeAvailableModelUpgrades({
  required Squad squad,
  required Model model,
}) {
  final merged = <String, ModelUpgrade>{
    for (final upgrade in model.availableModelUpgrades) upgrade.id: upgrade,
  };

  for (final upgrade
      in buildSquadProvidedModelUpgrades(squad: squad, model: model)) {
    merged[upgrade.id] = upgrade;
  }

  return merged.values.toList(growable: false);
}