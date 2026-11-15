import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/caprice/caprice_rule_set.dart';

class CapriceRuleSetLm extends CapriceRuleSet {
  const CapriceRuleSetLm(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CapriceRuleSetLm';
}
