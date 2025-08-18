import 'package:gearforce/src/models/roster/rules/assset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';

/// DefaultRuleSet is a predefined base RuleSet.
class DefaultRuleSet extends RuleSet {
  DefaultRuleSet()
    : super(
        name: 'Default Rule Set',
        rules: [],
        assetTable: AssetTable(
          greenSquads: 1,
          veteranSquads: 2,
          eliteSquads: 1,
          duelistOrAces: 1,
          airSupport: 2,
          artillerySupport: 2,
          droneSupport: 4,
        ),
      );

  @override
  String toString() => 'DefaultRuleSet';

  @override
  List<Unit> getAvailableUnits() {
    return const [];
  }
}
