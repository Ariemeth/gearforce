import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/nucoal/nucoal_rule_set.dart';

class NuCoalRuleSetKad extends NuCoalRuleSet {
  const NuCoalRuleSetKad(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'NuCoalRuleSetKad';
}
