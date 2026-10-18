import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/south/south_rule_set.dart';

class SouthRuleSetHa extends SouthRuleSet {
  const SouthRuleSetHa(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'SouthRuleSetHa';
}
