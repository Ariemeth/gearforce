import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/nucoal/nucoal_rule_set.dart';

class NuCoalRuleSetHscs extends NuCoalRuleSet {
  const NuCoalRuleSetHscs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NuCoalRuleSetHscs';
}
