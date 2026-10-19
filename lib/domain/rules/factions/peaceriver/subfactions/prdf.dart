import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/peaceriver_rule_set.dart';

class PeaceRiverRuleSetPrdf extends PeaceRiverRuleSet {
  const PeaceRiverRuleSetPrdf(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'PeaceRiverRuleSetPrdf';
}
