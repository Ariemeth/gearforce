import 'package:gearforce/src/models/roster/rules/assset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule.dart';

abstract class RuleSet {
  final String name;
  final String description;
  final AssetTable assetTable;
  final List<Rule> rules;

  RuleSet({
    required this.name,
    required this.description,
    required this.rules,
    required this.assetTable,
  });
}
