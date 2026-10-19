import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/utopia/utopia_rule_set.dart';

class UtopiaRuleSetIsk extends UtopiaRuleSet {
  const UtopiaRuleSetIsk(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'UtopiaRuleSetIsk';
}
