import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/eden/eden_rule_set.dart';

class EdenRuleSetNs extends EdenRuleSet {
  const EdenRuleSetNs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'EdenRuleSetNs';
}
