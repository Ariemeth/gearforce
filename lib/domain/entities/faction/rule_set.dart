import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/data/static/rules/base/command_level_rule.dart';
import 'package:gearforce/data/static/rules/base/squad_size_rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class RuleSet {
  final String name;
  final AssetTable assetTable;
  final List<Rule> extraRules;
  final SquadSizeRule squadSizeRule;
  final CommandLevelRule commandLevelRule;

  const RuleSet({
    required this.name,
    this.squadSizeRule = SquadSizeRule.standard,
    this.commandLevelRule = CommandLevelRule.standard,
    this.extraRules = const [],
    required this.assetTable,
  });

  List<Rule> get rules {
    return [squadSizeRule, commandLevelRule, ...extraRules];
  }

  List<Rule> get activeRules {
    return rules.where((rule) => rule.isEnabled).toList(growable: false);
  }

  int getEffectiveSquadUnitCount(Squad squad) {
    return _resolvedSquadSizeRule.getEffectiveUnitCount(squad.models);
  }

  bool isSquadComplete(Squad squad) {
    final sizeComplete = _resolvedSquadSizeRule.isComplete(squad.models);
    final commandComplete = _resolvedCommandLevelRule.isEnabled
        ? _resolvedCommandLevelRule.hasRequiredCommand(squad.models)
        : true;
    return sizeComplete && commandComplete;
  }

  bool canAddAnyUnitToSquad({required Squad squad}) {
    return _resolvedSquadSizeRule.canAddAnyModel(squad.models);
  }

  bool canAddUnitToSquad({required Squad squad, required Model unit}) {
    return _resolvedSquadSizeRule.canAddModel(squad.models, unit);
  }

  Future<List<Unit>> getAvailableUnits();

  bool canAssignCommandLevel({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    return _resolvedCommandLevelRule.canAssignCommandLevel(
      model: model,
      newCommandLevel: newCommandLevel,
      squad: squad,
      allSquads: allSquads,
    );
  }

  String? getCommandLevelValidationMessage({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    return _resolvedCommandLevelRule.getValidationMessage(
      model: model,
      newCommandLevel: newCommandLevel,
      squad: squad,
      allSquads: allSquads,
    );
  }

  List<({Squad squad, Model model})> getModelsToClearForCommandLevel({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    return _resolvedCommandLevelRule.getModelsToClear(
      model: model,
      newCommandLevel: newCommandLevel,
      squad: squad,
      allSquads: allSquads,
    );
  }

  SquadSizeRule get _resolvedSquadSizeRule {
    for (final rule in activeRules.reversed) {
      if (rule is SquadSizeRule) {
        return rule;
      }
    }

    return squadSizeRule;
  }

  CommandLevelRule get _resolvedCommandLevelRule {
    for (final rule in activeRules.reversed) {
      if (rule is CommandLevelRule) {
        return rule;
      }
    }

    return commandLevelRule;
  }
}
