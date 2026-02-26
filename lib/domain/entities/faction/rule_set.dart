import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/data/static/rules/base/squad_size_rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class RuleSet {
  final String name;
  final AssetTable assetTable;
  final List<Rule> extraRules;
  final SquadSizeRule squadSizeRule;

  const RuleSet({
    required this.name,
    this.squadSizeRule = SquadSizeRule.standard,
    this.extraRules = const [],
    required this.assetTable,
  });

  List<Rule> get rules {
    return [squadSizeRule, ...extraRules];
  }

  List<Rule> get activeRules {
    return rules.where((rule) => rule.isEnabled).toList(growable: false);
  }

  int getEffectiveSquadUnitCount(Squad squad) {
    return _resolvedSquadSizeRule.getEffectiveUnitCount(squad.models);
  }

  bool isSquadComplete(Squad squad) {
    return _resolvedSquadSizeRule.isComplete(squad.models);
  }

  bool canAddAnyUnitToSquad({required Squad squad}) {
    return _resolvedSquadSizeRule.canAddAnyModel(squad.models);
  }

  bool canAddUnitToSquad({required Squad squad, required Model unit}) {
    return _resolvedSquadSizeRule.canAddModel(squad.models, unit);
  }

  Future<List<Unit>> getAvailableUnits();

  SquadSizeRule get _resolvedSquadSizeRule {
    for (final rule in activeRules.reversed) {
      if (rule is SquadSizeRule) {
        return rule;
      }
    }

    return squadSizeRule;
  }
}
