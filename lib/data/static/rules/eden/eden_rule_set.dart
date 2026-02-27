import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/eden/eden_rules.dart';

class EdenRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const EdenRuleSet(this.unitRepository)
    : super(
        name: 'Eden',
        extraRules: edenRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'EdenRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.eden);
  }
}
