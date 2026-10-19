import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/black_talons/black_talon_rule_set.dart';

class BlackTalonRuleSetTit extends BlackTalonRuleSet {
  const BlackTalonRuleSetTit(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'BlackTalonRuleSetTit';
}
