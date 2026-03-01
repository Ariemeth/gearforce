import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/faction/asset_table.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/data/static/squad_upgrades.dart';
import 'package:gearforce/data/static/rules/base/command_level_rule.dart';
import 'package:gearforce/data/static/rules/base/squad_size_rule.dart';
import 'package:gearforce/data/static/rules/base/unit_level_rule.dart';
import 'package:gearforce/data/static/rules/base/duelist_rule.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

abstract class RuleSet {
  final String name;
  final AssetTable assetTable;
  final List<Rule> extraRules;
  final SquadSizeRule squadSizeRule;
  final CommandLevelRule commandLevelRule;
  final UnitLevelRule unitLevelRule;
  final DuelistRule duelistRule;
  final List<SquadUpgrade> availableSquadUpgrades;

  const RuleSet({
    required this.name,
    this.squadSizeRule = SquadSizeRule.standard,
    this.commandLevelRule = CommandLevelRule.standard,
    this.unitLevelRule = UnitLevelRule.standard,
    this.duelistRule = DuelistRule.standard,
    this.extraRules = const [],
    this.availableSquadUpgrades = SquadUpgrades.standard,
    required this.assetTable,
  });

  List<Rule> get rules {
    return [
      squadSizeRule,
      commandLevelRule,
      unitLevelRule,
      duelistRule,
      ...extraRules,
    ];
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

  bool canAssignUnitLevel({
    required Model model,
    required UnitLevel newLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    // Cannot make a duelist green
    if (newLevel == UnitLevel.green && model.isDuelist) {
      return false;
    }

    return _resolvedUnitLevelRule.canAssignUnitLevel(
      model: model,
      newLevel: newLevel,
      squad: squad,
      allSquads: allSquads,
      assetTable: assetTable,
    );
  }

  bool canAssignDuelist({
    required Model model,
    required bool newDuelistStatus,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    return _resolvedDuelistRule.canAssignDuelist(
      model: model,
      newDuelistStatus: newDuelistStatus,
      squad: squad,
      allSquads: allSquads,
      assetTable: assetTable,
    );
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

  /// Determines if a unit should have its command level cleared when changing to a new unit level.
  /// Returns true if the command should be cleared.
  bool shouldClearCommandOnLevelChange({
    required Model model,
    required UnitLevel newLevel,
    required Command currentCommand,
  }) {
    // If no command, nothing to clear
    if (currentCommand == Command.none) {
      return false;
    }

    // Check if the model could keep its current command at the new level
    // We create a temporary model with the new level to test
    final tempModel = model.copyWith(level: newLevel);
    return !_resolvedCommandLevelRule.canAssignCommandLevel(
      model: tempModel,
      newCommandLevel: currentCommand,
      squad: Squad(id: -1, name: '', primaryRole: Role.gp, models: [tempModel]),
      allSquads: [],
    );
  }

  /// Finds an eligible unit to auto-promote to the specified command level.
  /// Returns null if no eligible unit is found.
  Model? findEligibleUnitForCommandPromotion({
    required Command commandLevel,
    required List<Model> availableModels,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    for (final model in availableModels) {
      // Must currently have no command
      if (model.command != Command.none) {
        continue;
      }

      // Check if this model can be assigned the command level
      if (_resolvedCommandLevelRule.canAssignCommandLevel(
        model: model,
        newCommandLevel: commandLevel,
        squad: squad,
        allSquads: allSquads,
      )) {
        return model;
      }
    }

    return null;
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

  DuelistRule get _resolvedDuelistRule {
    for (final rule in activeRules.reversed) {
      if (rule is DuelistRule) {
        return rule;
      }
    }

    return duelistRule;
  }

  CommandLevelRule get _resolvedCommandLevelRule {
    for (final rule in activeRules.reversed) {
      if (rule is CommandLevelRule) {
        return rule;
      }
    }

    return commandLevelRule;
  }

  UnitLevelRule get _resolvedUnitLevelRule {
    for (final rule in activeRules.reversed) {
      if (rule is UnitLevelRule) {
        return rule;
      }
    }

    return unitLevelRule;
  }
}
