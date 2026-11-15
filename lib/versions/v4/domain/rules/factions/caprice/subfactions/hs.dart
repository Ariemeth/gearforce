import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/caprice/caprice_rule_set.dart';

class CapriceRuleSetHs extends CapriceRuleSet {
  const CapriceRuleSetHs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CapriceRuleSetHs';
}
