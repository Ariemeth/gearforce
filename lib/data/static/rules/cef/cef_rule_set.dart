import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/cef/cef_rules.dart';

class CefRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const CefRuleSet(this.unitRepository)
    : super(
        name: 'CEF',
        extraRules: cefRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'CefRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.cef);
  }
}
