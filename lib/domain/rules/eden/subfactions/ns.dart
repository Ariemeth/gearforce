import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/eden/eden_rule_set.dart';

class EdenRuleSetNs extends EdenRuleSet {
  const EdenRuleSetNs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'EdenRuleSetNs';
}
