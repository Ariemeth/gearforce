import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/south/south_rules.dart';

class SouthRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const SouthRuleSet(this.unitRepository)
    : super(
        name: 'South',
        extraRules: southRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'SouthRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.south);
  }
}
