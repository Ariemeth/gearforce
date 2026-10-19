import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/north/north_rule_set.dart';

class NorthRuleSetNlc extends NorthRuleSet {
  const NorthRuleSetNlc(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NorthRuleSetNlc';
}
