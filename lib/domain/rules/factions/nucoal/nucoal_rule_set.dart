import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/nucoal/nucoal_rules.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/hscs.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/kad.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/nsdf.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/pak.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/th.dart';

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

RuleSet getNuCoalSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.nuCoalSelfDefenseForce => NuCoalRuleSetNsdf(unitRepository),
    Subfaction.portArthurKorps => NuCoalRuleSetPak(unitRepository),
    Subfaction.khayrAdDin => NuCoalRuleSetKad(unitRepository),
    Subfaction.templeHeights => NuCoalRuleSetTh(unitRepository),
    Subfaction.hardScrabbledCityStates => NuCoalRuleSetHscs(unitRepository),
    _ => NuCoalRuleSet(unitRepository),
  };
}
