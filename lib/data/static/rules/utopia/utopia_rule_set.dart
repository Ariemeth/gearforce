import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/utopia/utopia_rules.dart';

class UtopiaRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const UtopiaRuleSet(this.unitRepository)
    : super(
        name: 'Utopia',
        extraRules: utopiaRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'UtopiaRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction(Faction.utopia);
  }
}
