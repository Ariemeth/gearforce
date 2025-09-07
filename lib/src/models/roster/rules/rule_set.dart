import 'package:gearforce/src/models/roster/rules/asset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';

abstract class RuleSet {
  final String name;
  final AssetTable assetTable;
  final List<Rule> rules;

  const RuleSet({
    required this.name,
    required this.rules,
    required this.assetTable,
  });

  List<Unit> getAvailableUnits();
}
