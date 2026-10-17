import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

/// DefaultRuleSet is a predefined base RuleSet.
class DefaultRuleSet extends RuleSet {
  DefaultRuleSet()
    : super(
        name: 'Default Rule Set',
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
  Future<List<Unit>> getAvailableUnits() async {
    return const [];
  }
}
