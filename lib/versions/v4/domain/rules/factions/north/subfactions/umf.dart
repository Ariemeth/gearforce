import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/north/north_rule_set.dart';

class NorthRuleSetUmf extends NorthRuleSet {
  const NorthRuleSetUmf(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NorthRuleSetUmf';
}
