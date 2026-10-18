import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/utopia/utopia_rule_set.dart';

class UtopiaRuleSetUrs extends UtopiaRuleSet {
  const UtopiaRuleSetUrs(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'UtopiaRuleSetUrs';
}
