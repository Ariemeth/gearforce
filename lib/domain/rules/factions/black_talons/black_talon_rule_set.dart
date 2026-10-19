import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/black_talons/black_talon_rules.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tat.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tit.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/trt.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tst.dart';

class BlackTalonRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const BlackTalonRuleSet(
    this.unitRepository, {
    super.name = 'Black Talon',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = blackTalonRuleCatalog,
  });

  @override
  String toString() => 'BlackTalonRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.blackTalons);
  }
}

RuleSet getBlackTalonSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.talonReconTeam => BlackTalonRuleSetTrt(unitRepository),
    Subfaction.talonInsertionTeam => BlackTalonRuleSetTit(unitRepository),
    Subfaction.talonAssaultTeam => BlackTalonRuleSetTat(unitRepository),
    Subfaction.talonStrikeTeam => BlackTalonRuleSetTst(unitRepository),
    _ => BlackTalonRuleSet(unitRepository),
  };
}
