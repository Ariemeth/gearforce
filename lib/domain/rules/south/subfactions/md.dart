import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/south/south_rule_set.dart';

class SouthRuleSetMd extends SouthRuleSet {
  const SouthRuleSetMd(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetMd';
}
