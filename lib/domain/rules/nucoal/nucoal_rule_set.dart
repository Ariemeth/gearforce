import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/nucoal/nucoal_rules.dart';

class NuCoalRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const NuCoalRuleSet(
    this.unitRepository, {
    super.name = 'NuCoal',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = nuCoalRuleCatalog,
  });

  @override
  String toString() => 'NuCoalRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.nuCoal);
  }
}
