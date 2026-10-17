import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/caprice/caprice_rules.dart';

class CapriceRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const CapriceRuleSet(this.unitRepository)
    : super(
        name: 'Caprice',
        extraRules: capriceRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'CapriceRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.caprice);
  }
}
