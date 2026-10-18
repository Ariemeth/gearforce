import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/peaceriver/peaceriver_rules.dart';

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
