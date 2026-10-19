import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/caprice/caprice_rule_set.dart';

class CapriceRuleSetCs extends CapriceRuleSet {
  const CapriceRuleSetCs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CapriceRuleSetCs';
}
