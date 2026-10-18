import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/north/north_rule_set.dart';

class NorthRuleSetWp extends NorthRuleSet {
  const NorthRuleSetWp(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NorthRuleSetWp';
}
