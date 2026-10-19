import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/caprice/caprice_rules.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/cms.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/cs.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/hs.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/lm.dart';

class CapriceRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const CapriceRuleSet(
    this.unitRepository, {
    super.name = 'Caprice',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = capriceRuleCatalog,
  });

  @override
  String toString() => 'CapriceRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.caprice);
  }
}

RuleSet getCapriceSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.hakkarSecurity => CapriceRuleSetHs(unitRepository),
    Subfaction.costaMoreiaSecurity => CapriceRuleSetCms(unitRepository),
    Subfaction.corporatiSecurity => CapriceRuleSetCs(unitRepository),
    Subfaction.liberatiMilitia => CapriceRuleSetLm(unitRepository),
    _ => CapriceRuleSet(unitRepository),
  };
}
