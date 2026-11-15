import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/south/south_rule_set.dart';

class SouthRuleSetEse extends SouthRuleSet {
  const SouthRuleSetEse(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetEse';
}
