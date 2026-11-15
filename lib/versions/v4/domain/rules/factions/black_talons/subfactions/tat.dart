import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/black_talons/black_talon_rule_set.dart';

class BlackTalonRuleSetTat extends BlackTalonRuleSet {
  const BlackTalonRuleSetTat(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'BlackTalonRuleSetTat';
}
