import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/north/north_rules.dart';

class NorthRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const NorthRuleSet(this.unitRepository)
    : super(
        name: 'North',
        extraRules: northRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'NorthRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.north);
  }
}
