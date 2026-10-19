import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/peaceriver_rules.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/poc.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/pps.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/prdf.dart';

class PeaceRiverRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const PeaceRiverRuleSet(
    this.unitRepository, {
    super.name = 'Peace River',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = peaceRiverRuleCatalog,
  });

  @override
  String toString() => 'PeaceRiverRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.peaceRiver);
  }
}

RuleSet getPeaceRiverSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.peaceRiverDefenseForce => PeaceRiverRuleSetPrdf(unitRepository),
    Subfaction.peaceOfficerCorps => PeaceRiverRuleSetPoc(unitRepository),
    Subfaction.paxtonPrivateSecurities => PeaceRiverRuleSetPps(unitRepository),
    _ => PeaceRiverRuleSet(unitRepository),
  };
}
