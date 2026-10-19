import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/eden/eden_rule_set.dart';

class EdenRuleSetSe extends EdenRuleSet {
  const EdenRuleSetSe(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'EdenRuleSetSe';
}
