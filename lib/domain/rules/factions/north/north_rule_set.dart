import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/north/north_rules.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/ng.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/nlc.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/umf.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/wp.dart';

class NorthRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const NorthRuleSet(
    this.unitRepository, {
    super.name = 'North',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = northRuleCatalog,
  });

  @override
  String toString() => 'NorthRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.north);
  }
}

RuleSet getNorthSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.norguard => NorthRuleSetNg(unitRepository),
    Subfaction.westernFrontierProtectorate => NorthRuleSetWp(unitRepository),
    Subfaction.unitedMercantileFederation => NorthRuleSetUmf(unitRepository),
    Subfaction.northernLightsConfederacy => NorthRuleSetNlc(unitRepository),
    _ => NorthRuleSet(unitRepository),
  };
}
