import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/peaceriver_rule_set.dart';

class PeaceRiverRuleSetPoc extends PeaceRiverRuleSet {
  const PeaceRiverRuleSetPoc(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'PeaceRiverRuleSetPoc';
}
