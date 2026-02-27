import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/peaceriver/peaceriver_rules.dart';

class PeaceRiverRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const PeaceRiverRuleSet(this.unitRepository)
    : super(
        name: 'Peace River',
        extraRules: peaceRiverRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'PeaceRiverRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.peaceRiver);
  }
}
