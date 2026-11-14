import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/new_jerusalem/new_jerusalem_rule_set.dart';

class NewJerusalemRuleSetOsm extends NewJerusalemRuleSet {
  const NewJerusalemRuleSetOsm(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NewJerusalemRuleSetOsm';
}
