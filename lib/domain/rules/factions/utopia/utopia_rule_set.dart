import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/ga.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/iap.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/is.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/isk.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/urs.dart';
import 'package:gearforce/domain/rules/factions/utopia/utopia_rules.dart';

class UtopiaRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const UtopiaRuleSet(
    this.unitRepository, {
    super.name = 'Utopia',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = utopiaRuleCatalog,
  });

  @override
  String toString() => 'UtopiaRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.utopia);
  }
}

RuleSet getUtopiaSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.unitedRepublicOfSteelgate => UtopiaRuleSetUrs(unitRepository),
    Subfaction.industrialStatesOfKogland => UtopiaRuleSetIsk(unitRepository),
    Subfaction.greenwayAlliance => UtopiaRuleSetGa(unitRepository),
    Subfaction.independentStates => UtopiaRuleSetIs(unitRepository),
    Subfaction.iAutoP => UtopiaRuleSetIap(unitRepository),
    _ => UtopiaRuleSet(unitRepository),
  };
}
