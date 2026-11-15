import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/cef/cef_rule_set.dart';

class CefRuleSetEaz extends CefRuleSet {
  const CefRuleSetEaz(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CefRuleSetEaz';
}
