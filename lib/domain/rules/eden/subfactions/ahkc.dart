import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/eden/eden_rule_set.dart';

class EdenRuleSetAhkc extends EdenRuleSet {
  const EdenRuleSetAhkc(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'EdenRuleSetAhkc';
}
