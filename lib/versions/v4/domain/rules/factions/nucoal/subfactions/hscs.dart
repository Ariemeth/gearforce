import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/nucoal/nucoal_rule_set.dart';

class NuCoalRuleSetHscs extends NuCoalRuleSet {
  const NuCoalRuleSetHscs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NuCoalRuleSetHscs';
}
