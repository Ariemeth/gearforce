import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/north/north_rule_set.dart';

class NorthRuleSetNg extends NorthRuleSet {
  const NorthRuleSetNg(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NorthRuleSetNg';
}
