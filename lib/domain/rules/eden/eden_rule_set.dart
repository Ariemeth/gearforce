import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/eden/eden_rules.dart';

class EdenRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const EdenRuleSet(
    this.unitRepository, {
    super.name = 'Eden',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = edenRuleCatalog,
  });

  @override
  String toString() => 'EdenRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.eden);
  }
}
