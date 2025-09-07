import 'package:gearforce/src/models/roster/rules/asset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/north/north_units.dart';

class NorthRuleSet extends RuleSet {
  NorthRuleSet()
    : super(name: 'North', rules: [], assetTable: const AssetTable.unlimited());

  @override
  String toString() => 'NorthRuleSet';

  @override
  List<Unit> getAvailableUnits() {
    return getNorthUnits();
  }
}
