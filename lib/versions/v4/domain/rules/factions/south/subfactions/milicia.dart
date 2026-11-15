import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/south/south_rule_set.dart';

class SouthRuleSetMilicia extends SouthRuleSet {
  const SouthRuleSetMilicia(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetMilicia';
}
