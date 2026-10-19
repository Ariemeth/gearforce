import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/south/south_rule_set.dart';

class SouthRuleSetMilicia extends SouthRuleSet {
  const SouthRuleSetMilicia(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetMilicia';
}
