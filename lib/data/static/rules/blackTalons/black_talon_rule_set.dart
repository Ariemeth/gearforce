import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/static/rules/blackTalons/black_talon_rules.dart';

class BlackTalonRuleSet extends RuleSet {
  final UnitRepository unitRepository;

  const BlackTalonRuleSet(this.unitRepository)
    : super(
        name: 'Black Talon',
        extraRules: blackTalonRuleCatalog,
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'BlackTalonRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() {
    return unitRepository.getUnitsByFaction('blackTalons');
  }
}
