import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/blackTalons/black_talon_rule_set.dart';

class BlackTalonRuleSetTrt extends BlackTalonRuleSet {
  const BlackTalonRuleSetTrt(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'BlackTalonRuleSetTrt';
}
