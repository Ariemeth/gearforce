import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/south/south_rules.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/ese.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/ha.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/md.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/milicia.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/sr.dart';

class SouthRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const SouthRuleSet(
    this.unitRepository, {
    super.name = 'South',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = southRuleCatalog,
  });

  @override
  String toString() => 'SouthRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.south);
  }
}

RuleSet getSouthSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.southernRepublic => SouthRuleSetSr(unitRepository),
    Subfaction.milicia => SouthRuleSetMilicia(unitRepository),
    Subfaction.mekongDominion => SouthRuleSetMd(unitRepository),
    Subfaction.easternSunEmirates => SouthRuleSetEse(unitRepository),
    Subfaction.humanistAlliance => SouthRuleSetHa(unitRepository),
    _ => SouthRuleSet(unitRepository),
  };
}
