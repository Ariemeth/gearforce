import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/nucoal/nucoal_rule_set.dart';

class NuCoalRuleSetTh extends NuCoalRuleSet {
  const NuCoalRuleSetTh(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NuCoalRuleSetTh';
}
