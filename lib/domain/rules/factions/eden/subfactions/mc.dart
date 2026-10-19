import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/eden/eden_rule_set.dart';

class EdenRuleSetMc extends EdenRuleSet {
  const EdenRuleSetMc(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'EdenRuleSetMc';
}
