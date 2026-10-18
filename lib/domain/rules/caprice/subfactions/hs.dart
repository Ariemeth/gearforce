import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/caprice/caprice_rule_set.dart';

class CapriceRuleSetHs extends CapriceRuleSet {
  const CapriceRuleSetHs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CapriceRuleSetHs';
}
