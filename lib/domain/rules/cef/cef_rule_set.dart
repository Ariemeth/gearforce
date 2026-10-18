import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/cef/cef_rules.dart';

class CefRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const CefRuleSet(
    this.unitRepository, {
    super.name = 'CEF',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = cefRuleCatalog,
  });

  @override
  String toString() => 'CefRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.cef);
  }
}
