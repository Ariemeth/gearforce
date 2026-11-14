import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/new_jerusalem/new_jerusalem_rules.dart';
import 'package:gearforce/domain/rules/factions/new_jerusalem/subfactions/osg.dart';
import 'package:gearforce/domain/rules/factions/new_jerusalem/subfactions/osj.dart';
import 'package:gearforce/domain/rules/factions/new_jerusalem/subfactions/osm.dart';

class NewJerusalemRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const NewJerusalemRuleSet(
    this.unitRepository, {
    super.name = 'New Jerusalem',
    super.assetTable = const AssetTable.unlimited(),
    super.extraRules = newJerusalemRuleCatalog,
  });

  @override
  String toString() => 'NewJerusalemRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.newJerusalem);
  }
}

RuleSet getNewJerusalemSubfactionRuleSet(
  Subfaction subfaction,
  UnitRepository unitRepository,
) {
  return switch (subfaction) {
    Subfaction.orderOfSaintMichael => NewJerusalemRuleSetOsm(unitRepository),
    Subfaction.orderOfSaintGeorge => NewJerusalemRuleSetOsg(unitRepository),
    Subfaction.orderOfSaintJoshua => NewJerusalemRuleSetOsj(unitRepository),
    _ => NewJerusalemRuleSet(unitRepository),
  };
}
