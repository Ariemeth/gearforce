import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/rules/factions/cef/cef_rule_set.dart';

class CefRuleSetGf extends CefRuleSet {
  const CefRuleSetGf(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CefRuleSetGf';
}
