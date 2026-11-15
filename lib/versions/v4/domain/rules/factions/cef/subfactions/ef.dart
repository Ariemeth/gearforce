import 'package:gearforce/versions/v4/domain/entities/faction/asset_table.dart';
import 'package:gearforce/versions/v4/domain/rules/factions/cef/cef_rule_set.dart';

class CefRuleSetEf extends CefRuleSet {
  const CefRuleSetEf(
    super.unitRepository, {
    super.assetTable = const AssetTable.one(),
  });

  @override
  String toString() => 'CefRuleSetEf';
}
