import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/south/south_rule_set.dart';

class SouthRuleSetMd extends SouthRuleSet {
  const SouthRuleSetMd(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetMd';
}
