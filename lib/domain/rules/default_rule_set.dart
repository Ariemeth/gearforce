import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

/// DefaultRuleSet is a predefined base RuleSet.
class DefaultRuleSet extends RuleSet {
  DefaultRuleSet({super.assetTable = const AssetTable.unlimited()})
    : super(name: 'Default Rule Set');

  @override
  String toString() => 'DefaultRuleSet';

  @override
  Future<List<Unit>> getAvailableUnits() async {
    return const [];
  }
}
