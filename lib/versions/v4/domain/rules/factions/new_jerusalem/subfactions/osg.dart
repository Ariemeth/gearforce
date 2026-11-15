import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/new_jerusalem/new_jerusalem_rule_set.dart';

class NewJerusalemRuleSetOsg extends NewJerusalemRuleSet {
  const NewJerusalemRuleSetOsg(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NewJerusalemRuleSetOsg';
}
