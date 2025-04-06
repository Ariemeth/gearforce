import 'package:gearforce/src/models/roster/rules/assset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';

/// DefaultRuleSet is a predefined RuleSet that can be used when no specific rules are required.
/// Eventually this ruleset no longer be used once subfaction rule sets are implemented for each faction.
class DefaultRuleSet extends RuleSet {
  DefaultRuleSet()
      : super(
          name: 'Default Rule Set',
          description: 'The default rule set with no special rules.',
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
}
