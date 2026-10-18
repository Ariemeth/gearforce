import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/peaceriver/peaceriver_rule_set.dart';

class PeaceRiverRuleSetPps extends PeaceRiverRuleSet {
  const PeaceRiverRuleSetPps(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'PeaceRiverRuleSetPps';
}
