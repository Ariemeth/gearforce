import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/new_jerusalem/new_jerusalem_rule_set.dart';

class NewJerusalemRuleSetOsj extends NewJerusalemRuleSet {
  const NewJerusalemRuleSetOsj(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NewJerusalemRuleSetOsj';
}
