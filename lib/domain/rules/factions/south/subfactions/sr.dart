import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/south/south_rule_set.dart';

class SouthRuleSetSr extends SouthRuleSet {
  const SouthRuleSetSr(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetSr';
}
