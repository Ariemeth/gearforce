import 'package:gearforce/src/models/roster/rules/assset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/north/north_units.dart';

class NorthRuleSet extends RuleSet {
  NorthRuleSet()
      : super(
          name: 'North',
          rules: [],
          assetTable: AssetTable(
            greenSquads: 2,
            veteranSquads: 2,
            eliteSquads: 1,
            duelistOrAces: 1,
            airSupport: 3,
            artillerySupport: 2,
            droneSupport: 4,
          ),
        );

  @override
  String toString() => 'NorthRuleSet';

  @override
  List<Unit> getAvailableUnits() {
    return getNorthUnits();
  }
}
