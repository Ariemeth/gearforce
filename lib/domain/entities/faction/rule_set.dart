import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class RuleSet {
  final String name;
  final AssetTable assetTable;
  final List<Rule> rules;

  const RuleSet({
    required this.name,
    required this.rules,
    required this.assetTable,
  });

  Future<List<Unit>> getAvailableUnits();
}
