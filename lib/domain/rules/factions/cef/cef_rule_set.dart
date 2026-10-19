import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/cef/cef_rules.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/eaz.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/ef.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/gf.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/rf.dart';

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

RuleSet getCefSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.expeditionaryForce => CefRuleSetEf(unitRepository),
    Subfaction.garrisonForce => CefRuleSetGf(unitRepository),
    Subfaction.earthAdministrationZone => CefRuleSetEaz(unitRepository),
    Subfaction.rebelForce => CefRuleSetRf(unitRepository),
    _ => CefRuleSet(unitRepository),
  };
}
