import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/nucoal/nucoal_rule_set.dart';

class NuCoalRuleSetPak extends NuCoalRuleSet {
  const NuCoalRuleSetPak(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NuCoalRuleSetPak';
}
