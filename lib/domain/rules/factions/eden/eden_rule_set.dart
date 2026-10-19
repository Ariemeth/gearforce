import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/eden/eden_rules.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ahkc.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ak.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/mc.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ns.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/se.dart';

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

RuleSet getEdenSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.seiathEmpire => EdenRuleSetSe(unitRepository),
    Subfaction.auduuthKingdom => EdenRuleSetAk(unitRepository),
    Subfaction.muratCorsairs => EdenRuleSetMc(unitRepository),
    Subfaction.nobleShareholders => EdenRuleSetNs(unitRepository),
    Subfaction.adHocKingdomOrConsortium => EdenRuleSetAhkc(unitRepository),
    _ => EdenRuleSet(unitRepository),
  };
}
