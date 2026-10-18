import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/north/north_rules.dart';

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
